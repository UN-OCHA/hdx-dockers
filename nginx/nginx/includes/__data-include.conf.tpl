    server_name ${HDX_PREFIX}data.${HDX_DOMAIN};
    root /srv/www/data;
    index index.html;

    gzip on;

    access_log /var/log/nginx/data.entry.access.log main;
    #hitec_timed_combined;
    error_log /var/log/nginx/data.entry.error.log;

    error_page 503 = /503.html;

    # make sure the page specified in here does exist at your root!
    include /etc/nginx/includes/maintenance_if.conf;

    include /etc/nginx/includes/on_418.conf;

    location @after_418 {
        try_files %uri @go_ahead;
    }

    # uncomment on staging to avoid bots indexeing
    #include /etc/nginx/includes/no-indexing-bots.conf;

    location / {

        include /etc/nginx/includes/err_418.conf;

        # simulate pingdom failure :)
        #if (%http_user_agent = "Pingdom.com_bot_version_1.4_(http://www.pingdom.com/)") {
        #    return 404;
        #}

        # uncomment on staging / dev
        #include /etc/nginx/includes/http-basic-auth.conf;


        try_files %uri @go_ahead;

        # added upon Sarah request 29.10.2014
        #rewrite /search.*q=ebolaaa /ebola redirect;

        #limit_req zone=zh400 burst=4000;

    }

    include /etc/nginx/snippets/ckan-static-stuffs.conf;

    include /etc/nginx/snippets/ckan-redirects.conf;

    include /etc/nginx/snippets/ckan-internal-services.conf;

    include /etc/nginx/snippets/ckan-external-upstreams.conf;

    include /etc/nginx/snippets/ckan-cache-adjust.conf;

    location @go_ahead {

        #access_log off;
        #log_not_found off;

        error_page 502 = /502.html;
        error_page 503 = /503.html;

        proxy_intercept_errors on;
        set_real_ip_from   127.0.0.1;

        proxy_redirect off;
        proxy_pass http://127.0.0.1:9220;
        # proxy_set_header Host %host;

        # proxy_set_header    X-Forwarded-For %remote_addr;
        # proxy_set_header    X-Forwarded-For %proxy_add_x_forwarded_for;
        # proxy_set_header    X-Real-IP %remote_addr;

        add_header          X-Nginx-Cache %upstream_cache_status;
        add_header          Access-Control-Allow-Origin *;

        # disabled to see if this is related with logout issue
        # expires                   5m;

        proxy_cache		cache;
        proxy_cache_key		"%request_method@%scheme://%server_name:%server_port%uri%args";
        proxy_http_version	1.1;
        proxy_buffers		100 1m;
        proxy_max_temp_file_size  10m;

        proxy_cache_valid         any 30s;
        proxy_cache_valid         200 1m;
        #########
        # was on! 30.04.2015
        #proxy_cache_bypass        302;
        #########
        # proxy_cache_valid         200 302 1m;
        # proxy_cache_valid         301 24h;
        # proxy_ignore_headers      Cache-Control Expires;

        # proxy_cache_bypass	%nocache;
        # proxy_no_cache            %nocache;
        # proxy_cache_lock	on;
        # proxy_cache_lock_timeout  2000;
        # proxy_cache_use_stale     error timeout invalid_header updating http_500;

        #proxy_cache_bypass %cookie_auth_tkt;
        #proxy_no_cache %cookie_auth_tkt;

        #limit_conn ckanlimit 300;
        #limit_req zone=zh5 burst=2 nodelay;
    }
