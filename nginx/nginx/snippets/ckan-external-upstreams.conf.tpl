location ^~ /tiles/ {
    #root /srv/www/static;
    #try_files %uri %uri/ =404;
    #error_page 404 = /errors/404.html;
    rewrite ^(/tiles/)(.*)% /tiles/1.0.0/osm/%2 break;
    #default_type image/png;
    proxy_set_header Host "otile3.mqcdn.com";
    proxy_pass http://otile3.mqcdn.com;
    proxy_redirect off;
    proxy_intercept_errors on;
    #proxy_cache tiles_cache;
    #proxy_temp_path /tmp/nginx_tiles_proxy 1 2;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
    #access_log off;
    #log_not_found_off;
}

# enable caching for the tiles at zoom level 6 (default map show)
location ^~ /crisis-tiles/6/ {
    rewrite ^(/crisis-tiles/)(.*)% /hot/%2 break;
    #default_type image/png;
    #proxy_pass http://crisismap;
    proxy_set_header Host "b.tile.openstreetmap.fr";
    proxy_pass http://b.tile.openstreetmap.fr;
    proxy_redirect off;
    proxy_intercept_errors on;
    proxy_cache crisis_tiles_cache;
    add_header X-Nginx-Cache %upstream_cache_status;
    #proxy_temp_path /tmp/nginx_tiles_proxy 1 2;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

location ^~ /crisis-tiles/ {
    # http://b.tile.openstreetmap.fr/hot/
    rewrite ^(/crisis-tiles/)(.*)% /hot/%2 break;
    #default_type image/png;
    proxy_set_header Host "b.tile.openstreetmap.fr";
    proxy_pass http://b.tile.openstreetmap.fr;
    proxy_redirect off;
    proxy_intercept_errors on;
    proxy_cache crisis_tiles_cache;
    add_header X-Nginx-Cache %upstream_cache_status;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

# hdx.mapbox.baselayer.url = 
# https://{s}.tiles.mapbox.com/v3/reliefweb.l43d4f5j/{z}/{x}/{y}.png
location ^~ /mapbox-base-tiles/ {
    # http://b.tile.openstreetmap.fr/hot/
    rewrite ^(/mapbox-base-tiles/)(.*)$ /v3/reliefweb.l43d4f5j/$2 break;
    #default_type image/png;
    # proxy_pass http://www.mapbox.com;
    proxy_set_header Host "b.tiles.mapbox.com";
    proxy_pass http://b.tiles.mapbox.com;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

# hdx.mapbox.labelslayer.url = 
# https://{s}.tiles.mapbox.com/v3/reliefweb.l43djggg/{z}/{x}/{y}.png
location ^~ /mapbox-layer-tiles/ {
    # http://b.tile.openstreetmap.fr/hot/
    rewrite ^(/mapbox-layer-tiles/)(.*)$ /v3/reliefweb.l43djggg/$2 break;
    #default_type image/png;
    proxy_set_header Host "b.tiles.mapbox.com";
    # proxy_pass http://www.mapbox.com;
    proxy_pass http://b.tiles.mapbox.com;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

# https://data.waterpointdata.org/resource/amwk-dedf.json
location = /data.waterpointdata.org/resource/amwk-dedf.json {
    rewrite ^(/data.waterpointdata.org/)(.*)$ /$2 break;
    proxy_set_header Host "data.waterpointdata.org";
    proxy_pass https://data.waterpointdata.org;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

# https://data.cityofchicago.org/resource/ydr8-5enu.json
location = /data.cityofchicago.org/resource/ydr8-5enu.json {
    rewrite ^(/data.cityofchicago.org/)(.*)$ /$2 break;
    proxy_set_header Host "data.cityofchicago.org";
    proxy_pass https://data.cityofchicago.org;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

#http://media.transparency.org/maps/cpi2015-470.html
location = /maps/cpi2015-470.html {
    sub_filter_once off;
    sub_filter "href=\"http://" "href=\"https://";
    proxy_set_header Host "media.transparency.org";
    proxy_pass http://media.transparency.org;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}

location = /visualization/wfp-indicators {
    rewrite ^(/visualization/wfp-indicators)$ /visualization/wfp-indicators/ permanent;
}

location ^~ /visualization/wfp-indicators {
    rewrite ^(/visualization/wfp-indicators)(.*)$ /hdx-wfp-indicators$2 break;
    proxy_set_header Host "ocha-dap.github.io";
    proxy_pass https://ocha-dap.github.io;
    proxy_redirect off;
    proxy_intercept_errors on;
    access_log /var/log/nginx/data.tiles.access.log upstreamlog;
    error_log /var/log/nginx/data.tiles.error.log;
}
