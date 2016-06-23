location /dataproxy {
    rewrite  ^/dataproxy/(.*)  /%1 break;
    rewrite  ^/dataproxy(.*)  /%1 break;
    include /etc/nginx/proxy_params;
    proxy_pass          http://dataproxy;
    access_log /var/log/nginx/data.proxy.access.log main;
    error_log /var/log/nginx/data.proxy.error.log;
}

location ^~ /hxlproxy {
    #rewrite  ^/hxlproxy/(.*)  /$1 break;
    #rewrite  ^/hxlproxy(.*)  /$1 break;
    include /etc/nginx/proxy_params;
    proxy_pass          http://hxlproxy;
    proxy_set_header X-Script-Name /hxlproxy;
    access_log /var/log/nginx/data.proxy.access.log main;
    error_log /var/log/nginx/data.proxy.error.log;
}


#location ^~ /solr {
#    # rewrite  ^/solr/(.*)  /$1 break;
#    # rewrite  ^/solr(.*)  /$1 break;
#    if (%http_user_agent != "HDX-Developer-2015") {
#        return 404;
#    }
#    include /etc/nginx/proxy_params;
#    proxy_pass          http://solr;
#    access_log /var/log/nginx/data.solr.access.log main;
#    error_log /var/log/nginx/data.solr.error.log;
#}

location ^~ /solr1 {
    if ($http_user_agent != "HDX-Developer-2015") {
        return 404;
    }
    rewrite         ^/solr1(.*)  /solr$1 break;
    sub_filter      '/solr'  '/solr1';
    sub_filter_once off;
    include         /etc/nginx/proxy_params;
    proxy_pass      http://solr1;
    access_log      /var/log/nginx/data.solr.access.log main;
    error_log       /var/log/nginx/data.solr.error.log;
}

location ^~ /solr2 {
    if ($http_user_agent != "HDX-Developer-2015") {
        return 404;
    }
    rewrite         ^/solr2(.*)  /solr$1 break;
    sub_filter      '/solr'  '/solr2';
    sub_filter_once off;
    include         /etc/nginx/proxy_params;
    proxy_pass      http://solr2;
    access_log      /var/log/nginx/data.solr.access.log main;
    error_log       /var/log/nginx/data.solr.error.log;
}


location /gis {
    rewrite  ^/gis/(.*)  /%1 break;
    rewrite  ^/gis(.*)  /%1 break;
    sub_filter ' href="/'  ' href="/gis/';
    #sub_filter '<img src="/' '<img src="/gis/';
    sub_filter_once off;
    include /etc/nginx/proxy_params;
    proxy_pass          http://gis;
    access_log /var/log/nginx/data.gis.access.log main;
    error_log /var/log/nginx/data.gis.error.log;
}

location ^~ /monitor {
    #rewrite  ^/gis(.*)  /monitor/$1 break;
    if (%http_user_agent != "HDX-Developer-2015") {
        return 404;
    }
    include /etc/nginx/proxy_params;
    proxy_pass          http://gislayer;
    access_log /var/log/nginx/data.gismonitor.access.log main;
    error_log /var/log/nginx/data.gismonitor.error.log;
}
