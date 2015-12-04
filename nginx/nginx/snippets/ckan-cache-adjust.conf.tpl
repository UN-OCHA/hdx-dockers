location ~* ^/fanstatic {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 7m;
    proxy_cache_valid 10m;
}

location ~* ^.+\.(css|js|jpg|png|svg|otf)% {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
    proxy_cache_valid 10m;
}

location ^~ /dataset/json-repository/resource_download {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
    proxy_cache_valid 1m;
}

location ^~ /api/action/datastore_search {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
    proxy_cache_valid 1m;
}


location ^~ /api/action/datastore_search_sql {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
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

location ^~ /organization/wfp {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
    proxy_cache_valid 1m;
}

location ^~ /group/nepal-earthquake {
    include /etc/nginx/snippets/ckan-cache-include.conf;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate, proxy-revalidate";
    expires 1m;
    proxy_cache_valid 1m;
}
