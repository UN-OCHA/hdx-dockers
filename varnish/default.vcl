vcl 4.0;

backend default {
  .host = "web";
  .port = "80";
  .connect_timeout = 120s;
  .first_byte_timeout = 120s;
  .between_bytes_timeout = 120s;
}

sub vcl_recv {
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
