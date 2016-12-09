# manage web server instance
server {

    listen 80;
    server_name ${HDX_PREFIX}centre.${HDX_DOMAIN} ${HDX_PREFIX}center.${HDX_DOMAIN};
    include /etc/nginx/snippets/redirect-to-https.conf;

    location / {
        alias /srv/www/centre;
        try_files $uri $uri/ =404;
        index index.html;
    }

}

server {

    listen 443 ssl;
    server_name ${HDX_PREFIX}centre.${HDX_DOMAIN} ${HDX_PREFIX}center.${HDX_DOMAIN};
    ssl_certificate     /etc/nginx/ssl.crt;
    ssl_certificate_key /etc/nginx/ssl.key;

    location / {
        alias /srv/www/centre;
        try_files $uri $uri/ =404;
        index index.html;
    }

}
