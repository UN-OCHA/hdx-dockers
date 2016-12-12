server {
    listen 80;
    server_name ${HDX_PREFIX}centre.${HDX_DOMAIN};
    include /etc/nginx/snippets/redirect-to-https.conf;
    location / {
        root /srv/www/centre;
        try_files $uri $uri/ =404;
        index index.html;
        include /etc/nginx/includes/http-basic-auth.conf;
    }
}

server {
    listen 443 ssl;
    server_name ${HDX_PREFIX}centre.${HDX_DOMAIN};
    ssl_certificate     /etc/nginx/ssl.crt;
    ssl_certificate_key /etc/nginx/ssl.key;
    location / {
        alias /srv/www/centre;
        try_files $uri $uri/ =404;
        index index.html;
        include /etc/nginx/includes/http-basic-auth.conf;
    }
}

server {
    listen 80;
    server_name ${HDX_PREFIX}center.${HDX_DOMAIN};
    return 301 $scheme://${HDX_PREFIX}centre.${HDX_DOMAIN};
}
