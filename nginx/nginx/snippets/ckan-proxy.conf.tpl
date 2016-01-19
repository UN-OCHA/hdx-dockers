# data (ckan) web server instance
server {


    set_real_ip_from   127.0.0.1;
    real_ip_header     X-Forwarded-For;

    listen 127.0.0.1:9220;
    root /srv/www/fake/;
    index index.html;

    access_log /var/log/nginx/data.access.log main;
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
        # proxy_set_header    Host %host;

        limit_req zone=zh400 burst=100; # nodelay;

        access_log /var/log/nginx/data.pass.access.log main;
        error_log /var/log/nginx/data.pass.error.log;
    }

}
