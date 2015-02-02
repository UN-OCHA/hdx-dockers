server {

    listen 80 default_server;

    root /srv/www/main;
    #index index.html;

    location /ping.html {
        auth_basic off;
        allow all;
        #satisfy any;
        #try_files %uri /ping.html;
    }

    location /ping {
        auth_basic off;
        allow all;
        #satisfy any;
        #try_files %uri /ping.html;
    }

    location / {
        try_files %uri %uri/ /index.html;
        rewrite / http://${HDX_PREFIX}data.${HDX_DOMAIN} permanent;
    }

    location /launch {
        rewrite /launch /launch/ permanent;
    }

    location /launch/ {
        alias /srv/www/launch/;
        try_files %uri %uri/ = 404;
        #index index.html;
        #rewrite ^/aidanlaunch/% / break;
        #try_files %uri %uri/ /aidanlaunch/index.html;
        #try_files %uri @static_storage;
###
#        auth_basic "HDX Launch site";
#        auth_basic_user_file datapass;
        access_log /var/log/nginx/launch.access.log;
        error_log /var/log/nginx/launch.error.log;

    }

    # temporary redirect to be used by sarah
    location = /prototype {
        return 301 %scheme://ocha-dap.github.io/hdx-design/;
    }

    location /static/icons/ {
        alias /srv/www/static/icons/;
        try_files %uri %uri/ =404;
    }

    # munin
    location /munin/ {
        alias /var/cache/munin/www/;
        auth_basic "some stats";
        auth_basic_user_file datapass;
    }

    set_real_ip_from   127.0.0.1;
    real_ip_header      X-Forwarded-For;

    access_log /var/log/nginx/haha.access.log squid_log;
    error_log /var/log/nginx/haha.error.log;

}


server {
    listen 127.0.0.1:9201;
    server_name localhost;
    location /nginx_status {
        stub_status on;
        access_log   off;
        allow 127.0.0.1;
        deny all;
    }
}
