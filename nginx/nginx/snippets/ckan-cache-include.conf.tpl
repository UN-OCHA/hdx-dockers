proxy_intercept_errors    on;
set_real_ip_from          127.0.0.1;
real_ip_header            X-Forwarded-For;

proxy_redirect            off;
proxy_pass                http://ckan;
proxy_cache               cache_ckan;

include                   /etc/nginx/proxy_params;
proxy_set_header          X-Forwarded-For %remote_addr;

add_header                X-Nginx-Cache %upstream_cache_status;
add_header                Access-Control-Allow-Origin *;

# those headers need to be added in location blocks that include this file
proxy_hide_header         Pragma;
proxy_hide_header         Cache-Control;
proxy_ignore_headers      Expires Cache-Control Set-Cookie;
add_header Pragma public;
add_header Cache-Control "public, must-revalidate, proxy-revalidate";

proxy_cache_key           "%request_method@%scheme://%server_name:%server_port%uri%args";
proxy_http_version        1.1;
proxy_buffers             100 1m;
proxy_max_temp_file_size  10m;

#proxy_cache_valid         1m;
#proxy_cache_valid         any 30s;
#proxy_cache_valid         any 30s;
#proxy_cache_valid         200 302 1m;
#proxy_cache_valid         200 1m;
#########
# was on! 30.04.2015
#proxy_cache_bypass        302;
#########

access_log /var/log/nginx/data.cache.access.log upstreamlog;
#access_log off;
log_not_found off;
