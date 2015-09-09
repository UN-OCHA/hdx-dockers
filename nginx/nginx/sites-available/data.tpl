# data (ckan) frontend caching instance
server {

    listen 80;
    listen 443 ssl;
    server_name ${HDX_PREFIX}data.${HDX_DOMAIN};
    ssl_certificate     /etc/ssl/certs/hdx.rwlabs.org.crt;
    ssl_certificate_key /etc/ssl/private/hdx.rwlabs.org.key;
    root /srv/www/data;
    index index.html;

    gzip on;

    access_log /var/log/nginx/data.entry.access.log hitec_timed_combined;
    error_log /var/log/nginx/data.entry.error.log;

    error_page 503 = /503.html;

    set_real_ip_from   172.17.42.1;
    #set_real_ip_from   10.66.32.65;
    #real_ip_header     X-Forwarded-For;

    location / {
        # let developers run some api ckan scripts
        # when the http basic auth is on
        # (can't have more than one auth header and that is for ckan api key)
        #error_page 418 = @hellodevelopers;
        #if (%http_user_agent = "HDX-Developer-2015") {
        #    return 418;
        #}

        #if (%http_user_agent = "Pingdom.com_bot_version_1.4_(http://www.pingdom.com/)") {
        #    return 404;
        #}

        try_files %uri @go_ahead;

        # added upon Sarah request 29.10.2014
        #rewrite /search.*q=ebolaaa /ebola redirect;

        #limit_req zone=zh400 burst=4000;

        #auth_basic "HDX site";
        #auth_basic_user_file ${HDX_TYPE}-datapass;

        #allow 127.0.0.1;
        #allow 172.16.0.0/12;
        #deny all;

        #satisfy any;
    }

    location /data-ebola-public.xlsx {
        root /srv/www/permalinks/;
        expires -1;
        try_files %uri =404;
    }

    location /permalinks/ {
        alias /srv/www/permalinks/;
        expires -1;
        try_files %uri =404;
    }

    location /search {
        error_page 418 = @go_ahead;
        error_page 419 = @ebola_page;
        #error_page 420 = @go_ahead;
        error_page 420 = @colombia_page;
        recursive_error_pages on;
        if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=ebola(%|&)") {
            return 418;
        }
        if (%args ~* "(^|&)q=ebola(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
            return 418;
        }
        if (%args ~* "(^|(.*)&)q=ebola(%|&)") {
            return 419;
        }
        if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=colombia(%|&)") {
            return 418;
        }
        if (%args ~* "(^|&)q=colombia(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
            return 418;
        }
        if (%args ~* "(^|(.*)&)q=colombia(%|&)") {
            return 420;
        }
        try_files %uri @go_ahead;
    }

    location /ruby {
        rewrite .* /dataset?tags=ruby&_show_filters=false last;
    }

    location = /nepal-earthquake {
        rewrite .* /group/nepal-earthquake last;
    }

    location ~* ^/nepal[._-]?(earth)?quake {
        #rewrite .* /dataset?tags=nepal+earthquake last;
        #rewrite .* /group/nepal-earthquake permanent;
        rewrite .* /nepal-earthquake permanent;
    }

    location @ebola_page {
            rewrite .* /ebola? permanent;
    }

    location /colombia {
            rewrite .* /group/col? permanent;
    }

    location @colombia_page {
            rewrite .* /group/col? permanent;
    }

    location ~* /topic/.* {
            rewrite /topic/(.*) /dataset?tags=%1&_show_filters=false permanent;
    }

    location /(503.html|hdx-logo-alpha.png) {
        try_files %uri = 404;
        #limit_req zone=zh400 burst=4000;
    }
    # test nginx is on
    location = /ping {
        auth_basic off;
        allow all;
        #satisfy any;
        #try_files %uri /pong.html;
    }

    # setting the cors header
    #location /api/i18n/en_AU {
    #    add_header Access-Control-Allow-Origin ".hdx.rwlabs.org";
    #    try_files %uri @go_ahead;
    #}

    location /_tracking {
        add_header Access-Control-Allow-Origin "${HDX_PREFIX}data.${HDX_DOMAIN}";
        try_files %uri @go_ahead;
    }

    #location @hellodevelopers {
    #    try_files %uri @go_ahead;
    #}

    location /dataset/rowca-ebola-cases/related {
        rewrite /dataset/rowca-ebola-cases/(.*) /dataset/rowca-ebola-cases/ permanent;
        try_files %uri @go_ahead;
    }

    location ~ /err/(.*)\.(html|png)% {
        alias /srv/www/static/err/;
        #limit_req zone=zh400 burst=200;
    }

    # static errors
    location /errors/ {
        root /srv/www/static;
        try_files %uri %uri/;
    }

    # deflect ckan vulnerability - suggested by ALex @ 14.02.2015
    location /api/action/current_package_list_with_resources {
        return 418;
    }

    #location ~ \.(js|css|png|svg|otf)% {
    #    try_files %uri @go_ahead;
    #    #limit_req zone=zh400 burst=25 nodelay;
    #}

    location /dataproxy {
        rewrite  ^/dataproxy/(.*)  /%1 break;
        rewrite  ^/dataproxy(.*)  /%1 break;
        proxy_pass          http://dataproxy;
        access_log /var/log/nginx/data.proxy.access.log;
        error_log /var/log/nginx/data.proxy.error.log;
    }

    location /gis {
        rewrite  ^/gis/(.*)  /%1 break;
        rewrite  ^/gis(.*)  /%1 break;
        proxy_pass          http://gis;
        access_log /var/log/nginx/data.gis.access.log;
        error_log /var/log/nginx/data.gis.error.log;
    }

    location ^~ /monitor {
        #rewrite  ^/gis(.*)  /monitor/$1 break;
        if (%http_user_agent != "HDX-Developer-2015") {
            return 404;
        }
        proxy_pass          http://gislayer;
        access_log /var/log/nginx/data.gismonitor.access.log;
        error_log /var/log/nginx/data.gismonitor.error.log;
    }

    location ^~ /tiles/ {
        #root /srv/www/static;
        #try_files %uri %uri/ =404;
        #error_page 404 = /errors/404.html;
        rewrite ^(/tiles/)(.*)% /tiles/1.0.0/osm/%2 break;
        #default_type image/png;
        proxy_pass http://otile3.mqcdn.com;
        proxy_redirect off;
        proxy_intercept_errors on;
        #proxy_cache tiles_cache;
        #proxy_temp_path /tmp/nginx_tiles_proxy 1 2;
        access_log /var/log/nginx/data.tiles.access.log;
        error_log /var/log/nginx/data.tiles.error.log;
        #access_log off;
        #log_not_found_off;
    }

    # enable caching for the tiles at zoom level 6 (default map show)
    location ^~ /crisis-tiles/6/ {
        rewrite ^(/crisis-tiles/)(.*)% /hot/%2 break;
        #default_type image/png;
        #proxy_pass http://crisismap;
        proxy_pass http://b.tile.openstreetmap.fr;
        proxy_redirect off;
        proxy_intercept_errors on;
        proxy_cache crisis_tiles_cache;
        add_header X-Nginx-Cache %upstream_cache_status;
        #proxy_temp_path /tmp/nginx_tiles_proxy 1 2;
        access_log /var/log/nginx/data.tiles.access.log;
        error_log /var/log/nginx/data.tiles.error.log;
    }

    location ^~ /crisis-tiles/ {
        # http://b.tile.openstreetmap.fr/hot/
        rewrite ^(/crisis-tiles/)(.*)% /hot/%2 break;
        #default_type image/png;
        proxy_pass http://b.tile.openstreetmap.fr;
        proxy_redirect off;
        proxy_intercept_errors on;
        proxy_cache crisis_tiles_cache;
        add_header X-Nginx-Cache %upstream_cache_status;
        access_log /var/log/nginx/data.tiles.access.log;
        error_log /var/log/nginx/data.tiles.error.log;
    }

    # hdx.mapbox.baselayer.url = 
    # https://{s}.tiles.mapbox.com/v3/reliefweb.l43d4f5j/{z}/{x}/{y}.png
    location ^~ /mapbox-base-tiles/ {
        # http://b.tile.openstreetmap.fr/hot/
        rewrite ^(/mapbox-base-tiles/)(.*)$ /v3/reliefweb.l43d4f5j/$2 break;
        #default_type image/png;
        # proxy_pass http://www.mapbox.com;
        proxy_pass http://b.tiles.mapbox.com;
        proxy_redirect off;
        proxy_intercept_errors on;
        access_log /var/log/nginx/data.tiles.access.log;
        error_log /var/log/nginx/data.tiles.error.log;
    }

    # hdx.mapbox.labelslayer.url = 
    # https://{s}.tiles.mapbox.com/v3/reliefweb.l43djggg/{z}/{x}/{y}.png
    location ^~ /mapbox-layer-tiles/ {
        # http://b.tile.openstreetmap.fr/hot/
        rewrite ^(/mapbox-layer-tiles/)(.*)$ /v3/reliefweb.l43djggg/$2 break;
        #default_type image/png;
        # proxy_pass http://www.mapbox.com;
        proxy_pass http://b.tiles.mapbox.com;
        proxy_redirect off;
        proxy_intercept_errors on;
        access_log /var/log/nginx/data.tiles.access.log;
        error_log /var/log/nginx/data.tiles.error.log;
    }

    location ~ /err/(.*)\.(html|png)% {
        alias /srv/www/static/err/;
    }

    location /serbanux/ {
        alias /srv/www/static/test;
        try_files %uri %uri/ = 503;
    }

    #disabled - related to concern about provate datasets and resources - on 27 Oct 2014
    #location /storage/f/ {
    ##if (%http_user_agent = "Python-urllib/2.7 AppEngine-Google; (+http://code.google.com/appengine; appid: s~jsonpdataproxy-hrd)") {
    #    rewrite ^/storage/f/(.*)% /de/fa/ul/t/obj/%1 last;
    ##} 
    #}

    # same as above
    #location /de/fa/ul/t/obj {
    #    allow all;
    #    root /srv/www/data/pairtree_root;
    #    access_log /var/log/nginx/data.static.access.log;
    #    error_log /var/log/nginx/data.static.error.log;
    #    try_files %uri @go_ahead;
    #}

    include /etc/nginx/includes/ckan-cache-adjust.conf;


    location @go_ahead {

        #access_log off;
        #log_not_found off;

        error_page 502 = /502.html;
        error_page 503 = /503.html;

        proxy_intercept_errors on;
        set_real_ip_from   127.0.0.1;

        # rewrite ^ %scheme://test.docs.hdx.rwlabs.org%request_uri redirect;
        # test proxy timing
        #access_log /var/log/nginx/proxy.docs.access.log upstreamlog;
        proxy_redirect off;
        proxy_pass http://127.0.0.1:9220;
        proxy_set_header Host %host;

        proxy_set_header    X-Forwarded-For %remote_addr;
        # proxy_set_header    X-Forwarded-For %proxy_add_x_forwarded_for;
        proxy_set_header    X-Real-IP %remote_addr;

        # add_header                X-Proxy-Cache %upstream_cache_status;
        add_header	X-Nginx-Cache %upstream_cache_status;
        add_header Access-Control-Allow-Origin *;

        # disabled to see if this is related with logout issue
        # expires                   5m;

        proxy_cache		cache;
        proxy_cache_key		"%request_method@%scheme://%server_name:%server_port%uri%args";
        proxy_http_version	1.1;
        proxy_buffers		100 1m;
        proxy_max_temp_file_size  10m;

        proxy_cache_valid         any 30s;
        # proxy_cache_valid         200 302 1m;
        proxy_cache_valid         200 1m;
        #########
        # was on! 30.04.2015
        #proxy_cache_bypass        302;
        #########
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

}


# data (ckan) web server instance
server {


    set_real_ip_from   127.0.0.1;
    real_ip_header     X-Forwarded-For;

    listen 127.0.0.1:9220;
    root /srv/www/fake/;
    index index.html;

    access_log /var/log/nginx/data.access.log;
    error_log /var/log/nginx/data.error.log;

    #gzip on;

    location / {
        # checks for static file, if not found proxy to app
        try_files %uri @pass_to_ckan;
        #limit_req zone=zh5 burst=2 nodelay;
        #limit_conn ckanlimit 3;
    }

    #location ~ \.(js|css|png|svg|otf)% {
    #    try_files %uri @go_ahead;
    #    limit_req zone=zh800 burst=800; # nodelay;
    #}#

    location @pass_to_ckan {
        #try_files %uri %uri/;
        # /index.html;
        #try_files %uri @ckan;

        proxy_pass          http://ckan;
        proxy_redirect      off;
        proxy_set_header    Host %host;

        limit_req zone=zh400 burst=100; # nodelay;

        access_log /var/log/nginx/data.pass.access.log;
        error_log /var/log/nginx/data.pass.error.log;
    }

}
