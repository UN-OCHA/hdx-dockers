location ~* ^/fanstatic {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 7m;
    proxy_cache_valid 10m;
}

location ~* ^/images/.+\.(css|js|jpg|png|svg|otf)$ {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 7m;
    proxy_cache_valid 10m;
}

location ~* ^/api/i18n/en_AU$ {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 7m;
    proxy_cache_valid 10m;
}

location ^~ ^/fonts {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 7m;
    proxy_cache_valid 10m;
}

location ~* ^.+\.(css|js|jpg|png|svg|otf)% {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 1m;
    proxy_cache_valid 10m;
}

location ^~ /dataset/json-repository/resource_download {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 1m;
    proxy_cache_valid 1m;
}

location ^~ /api/action/datastore_search {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 1m;
    proxy_cache_valid 1m;
}

location ^~ /api/action/datastore_search_sql {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    error_page 418 = @22748b40dd-7bd3-40a3-941b-e76f0bfbe0eb;
    recursive_error_pages on;
    if ($args ~ "22748b40dd-7bd3-40a3-941b-e76f0bfbe0eb") { 
        return 418;
    }
    expires 1m;
    proxy_cache_valid 1m;
}

location @22748b40dd-7bd3-40a3-941b-e76f0bfbe0eb {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    expires 60m;
    proxy_cache_valid 1m;
}

#location ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)% {
#    expires 4w;
#    access_log off;
#    log_not_found off;
#    add_header Pragma public;
#    # not really needed - those are not auth related :)
#    # add_header Cache-Control "public, must-revalidate, proxy-revalidate";
#}

# see https://github.com/OCHA-DAP/hdx-ckan/issues/4190
#location ^~ /organization/wfp {
#    include /etc/nginx/snippets/ckan-cache-include.conf;
#    expires 1m;
#    proxy_cache_valid 1m;
#}

# see https://github.com/OCHA-DAP/hdx-ckan/issues/4190
#location ^~ /group/nepal-earthquake {
#    include /etc/nginx/snippets/ckan-cache-include.conf;
#    expires 1m;
#    proxy_cache_valid 1m;
#}
