# Set $_SERVER['HTTPS'] for PHP if we're behind HAProxy terminating SSL
# ($http_x_forwarded_proto) or native nginx SSL termination ($https).
map $http_x_forwarded_proto $fastcgi_https {
  default $https;
  http '';
  https on;
}

# wordpress caching instance
server {

    listen 80;
    listen 443 ssl;
    server_name ${HDX_PREFIX}docs.${HDX_DOMAIN};
    ssl_certificate     /etc/ssl/certs/hdx.rwlabs.org.crt;
    ssl_certificate_key /etc/ssl/private/hdx.rwlabs.org.key;

    location ~ /(.*)% {
        #access_log off;
        # test proxy timing
        #access_log /var/log/nginx/proxy.docs.access.log upstreamlog;
        #log_not_found off;
        proxy_redirect off;
        proxy_pass http://127.0.0.1:9211;
        proxy_set_header Host %host;
        include includes/proxy.conf;
    }

}

# wordpress blog server instance
server {

    listen 127.0.0.1:9211;
    root /srv/www/docs;
    access_log /var/log/nginx/docs.access.log;
    error_log /var/log/nginx/docs.error.log;

    include includes/restrictions.conf;
    include includes/cache-adjust.conf;

    location / {
        try_files %uri %uri/ /index.php?%args;
        index index.php;
    }

    # Add trailing slash to */wp-admin requests.
    rewrite /wp-admin% %scheme://%host%uri/ permanent;

    # Pass all .php files to the php-fpm server.
    location ~ ^.+\.php% {
        limit_req   zone=z100  burst=10;
        limit_req_log_level info;

        fastcgi_split_path_info ^(.+\.php)(/.+)%;
        include fastcgi_params;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME %document_root%fastcgi_script_name;
        fastcgi_param HTTPS $fastcgi_https;
        # fastcgi_intercept_errors on;
        fastcgi_pass blog;
    }

}
