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

location ^~ /visualization {
    alias /srv/www/visualization/;
    try_files $uri $uri/ =404;
    index index.html;
}

location /search {
    error_page 419 = @go_ahead;
    error_page 420 = @ebola_page;
    error_page 421 = @colombia_page;
    recursive_error_pages on;
    if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=ebola(%|&)") {
        return 418;
    }
    if (%args ~* "(^|&)q=ebola(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
        return 419;
    }
    #if (%args ~* "(^|(.*)&)q=ebola(%|&)") {
    #    return 420;
    #}
    if (%args ~* "(^|&)ext_indicator=(0|1)(&|&(.*)|(.*)&)q=colombia(%|&)") {
        return 419;
    }
    if (%args ~* "(^|&)q=colombia(&|&(.*)|(.*)&)ext_indicator=(0|1)(%|&)") {
        return 419;
    }
    #if (%args ~* "(^|(.*)&)q=colombia(%|&)") {
    #    return 421;
    #}
    try_files %uri @go_ahead;
}

location /ruby {
    rewrite .* /dataset?tags=ruby&_show_filters=false last;
}

location /cod {
    rewrite .* /dataset?tags=cod&sort=title_case_insensitive+asc&_show_filters=false last;
}

location /elnino-2015 {
    rewrite .* /search?q=el+nino permanent;
}

location /group/elnino-2015 {
    rewrite .* /search?q=el+nino permanent;
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

location ^~ /solr {
    # rewrite  ^/solr/(.*)  /$1 break;
    # rewrite  ^/solr(.*)  /$1 break;
    if (%http_user_agent != "HDX-Developer-2015") {
        return 404;
    }
    proxy_pass          http://solr;
    access_log /var/log/nginx/data.solr.access.log;
    error_log /var/log/nginx/data.solr.error.log;
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
