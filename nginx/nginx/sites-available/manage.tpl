# manage web server instance
server {

    listen 80;
    listen 443 ssl;
    ssl_certificate     /etc/ssl/certs/hdx.rwlabs.org.crt;
    ssl_certificate_key /etc/ssl/private/hdx.rwlabs.org.key;
    server_name ${HDX_PREFIX}manage.${HDX_DOMAIN};
    root /srv/www/manage;
    index index.html;
    error_page 404 @foobar;

    location @foobar {
        rewrite  .*  /404.jpg permanent;
    }

    # make sure the page specified in here does exist at your root!
    include /etc/nginx/includes/maintenance_if.conf;

    location / {
#        rewrite .* /hdx/login/ permanent;
#    }

#    location /hdx {
#        #try_files %uri %uri/ /index.html;
        proxy_pass          http://cps;

        proxy_redirect      off;
        proxy_set_header    Host %host;
        #proxy_intercept_errors on;
    }

    location /hdx/api/exporter/ {
        rewrite /hdx/(.*) /%1 permanent;
    }

    # serve static content :)
    location /api/exporter {
        root /srv/www/static/cps/hdx;
        autoindex off;
        #proxy_intercept_errors on;
        #error_page 404 @foobar;
        try_files %uri %uri/ @cps_really;
        #access_log off;
        #error_log off;
        access_log /var/log/nginx/manage.static.access.log;
        error_log /var/log/nginx/manage.static.error.log;
    }

    location @cps_really {
        proxy_pass          http://cps;
        proxy_cache	    cache_cps;
        proxy_redirect      off;
        proxy_set_header    Host %host;
        # the location that sent you here needs to set this or not.
        #proxy_intercept_errors on;
        proxy_intercept_errors on;
        #error_page 404 @foobar;

    }

#    location @cps_test_wfp {
#        proxy_pass          http://cps;
##        #proxy_cache	    cache_cps;
#        proxy_redirect      off;
#        proxy_set_header    Host %host;
#        # the location that sent you here needs to set this or not.
#        #proxy_intercept_errors on;
#        proxy_intercept_errors on;
#        #error_page 404 @foobar;
#
#    }


    access_log /var/log/nginx/manage.access.log;
    error_log /var/log/nginx/manage.error.log;

}
