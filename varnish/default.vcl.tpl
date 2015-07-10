vcl 4.0;

acl purge {
  "localhost";
  "127.0.0.1";
  "172.17.42.0"/16; # Docker bridge.
  "10.5.51.0"/24;   # 568elmp01 private
  "10.5.52.0"/24;   # 568elmp02 private
  "10.5.68.0"/24;   # Internal BlackMesh routing
  "10.5.101.0"/24;  # 568elwb01 private
  "10.5.102.0"/24;  # 568elwb02 private
  "10.5.201.0"/24;  # 568eldb01 private
  "10.5.202.0"/24;  # 568eldb02 private
}

backend default {
  .host = "${HDX_NGINX_HOST}"; # Assume this will always be a Docker link for now.
  .port = "${HDX_NGINX_PORT}";
  .connect_timeout = 120s;
  .first_byte_timeout = 120s;
  .between_bytes_timeout = 120s;
}

sub vcl_recv {
  # Allow purging by hitting /purge/all or /purge/$HOST/$URL with a "PURGE" verb.
  if (req.method == "PURGE") {
    # Check the above ACL.
    if (!client.ip ~ purge) {
      return(synth(403, "Not allowed."));
    }

    if (req.url ~ "^/purge/all$") {
      ban("obj.http.x-url ~ ^/");
      # Throw a synthetic page so no beresp is created.
      return(synth(200, "All pages purged."));
    }
    elseif (req.url ~ "^/purge/") {
      # You have to set headers to do variables. Yarr.
      set req.http.x-purge-host = regsub(req.url, "^/purge/([^/]+)/.*$", "\1");
      set req.http.x-purge-path = regsub(req.url, "^/purge/[^/]+(/.*)$", "\1");
      ban("obj.http.x-host == " + req.http.x-purge-host + " && obj.http.x-url == " + req.http.x-purge-path);

      # Throw a synthetic page so no beresp is created.
      return(synth(200, "Purged path " + req.http.x-purge-path + " from hostname " + req.http.x-purge-host + "."));
    }
    else {
      # Throw a synthetic warning page.
      return(synth(500, "Improper purge request."));
    }
  }

  # Redirect non-HTTP to HTTPS. See vcl_synth.
  if ("${HDX_HTTPS_REDIRECT}" == "on" && req.http.x-forwarded-proto == "http") {
    return (synth(750, ""));
  }

  # Remove all cookies on static requests.
  if (req.url ~ "\.(aif|aiff|au|avi|bin|bmp|cab|carb|cct|cdf|class|css|dcr|doc|dtd|eot|exe|flv|gcf|gff|gif|grv|hdml|hqx|html|ico|ini|jpeg|jpg|js|mov|mp3|nc|pct|pdf|pdf|png|png|ppc|pws|svg|swa|swf|swf|ttf|txt|vbs|w32|wav|wbmp|wml|wmlc|wmls|wmlsc|woff|xml|xsd|xsl|zip)") {
    unset req.http.cookie;
  }

  # Strip any cookie that starts with _ga (the main analytics cookies.)
  set req.http.cookie = regsuball(req.http.cookie, "(^|(?<=; )) *_ga[^=]*=[^;]+;? *", "\1");

  if (req.http.cookie == "") {
    unset req.http.cookie;
  }

  # Do not cache a request if any cookies remain.
  if (req.http.cookie) {
    return (pass);
  }
}

sub vcl_synth {
  # Create synthetic redirect responses via a 750 status code.
  if (resp.status == 750) {
    set resp.status = 301;
    set resp.http.Location = "https://" + req.http.host + req.url;
    return(deliver);
  }
}

sub vcl_hash {
  # Differentially cache the HTTP and HTTPS versions of pages, which will look
  # the same except for an "X-Forwarded-Proto" set to "http" or "https".
  if (req.http.x-forwarded-proto) {
    hash_data(req.http.x-forwarded-proto);
  }

  # Allow basic auth to be cached.
  if (req.http.authorization) {
    hash_data(req.http.authorization);
  }
}

sub vcl_backend_response {
  # Add an X-Host and X-URL header for bans.
  set beresp.http.x-host = bereq.http.host;
  set beresp.http.x-url = bereq.url;

  # Strip any cookies before a static resource is inserted into cache.
  if (bereq.url ~ "\.(aif|aiff|au|avi|bin|bmp|cab|carb|cct|cdf|class|css|dcr|doc|dtd|eot|exe|flv|gcf|gff|gif|grv|hdml|hqx|html|ico|ini|jpeg|jpg|js|mov|mp3|nc|pct|pdf|pdf|png|png|ppc|pws|svg|swa|swf|swf|ttf|txt|vbs|w32|wav|wbmp|wml|wmlc|wmls|wmlsc|woff|xml|xsd|xsl|zip)") {
    unset beresp.http.set-cookie;
  }

  # Make sure a browser would never cache an uncacheable (e.g. 50x) response.
  if (beresp.ttl <= 0s) {
    set beresp.http.Cache-Control = "no-cache, no-store, must-revalidate";
  }

  # Keep this around for 4 hours past its TTL. This will allow Varnish 4 to
  # re-update it in the background.
  set beresp.grace = 4h;
  set beresp.keep = 4h;

  # You _may_ want to return a hit-for-pass here, or disable it, depending on
  # if you expect to have a lot of non-cacheable responses.
  #
  # The default here will fall through to Varnish's default processing logic
  # which will sent a 2 minute hit-for-pass if this URL returns an uncacheable
  # response.
  #
  # Uncomment the following line to never hit-for-pass.
  return (deliver);
}

sub vcl_deliver {
  # Don't output these cache debug headers.
  unset resp.http.x-host;
  unset resp.http.x-url;
}
