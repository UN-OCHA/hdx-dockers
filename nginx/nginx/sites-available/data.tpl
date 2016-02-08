# data (ckan) frontend caching instance
server {

    listen 80;

    include /etc/nginx/snippets/redirect-to-https.conf;
    include /etc/nginx/includes/__data-include.conf;

}

server {

    listen 443 ssl;
    ssl_certificate     /etc/nginx/ssl.crt;
    ssl_certificate_key /etc/nginx/ssl.key;

    include /etc/nginx/includes/__data-include.conf;

}

include /etc/nginx/snippets/ckan-proxy.conf;
