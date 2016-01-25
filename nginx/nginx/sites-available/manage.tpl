# manage web server instance
server {

    listen 80;
    include /etc/nginx/snippets/redirect-to-https.conf;
    include /etc/nginx/includes/__manage-include.conf;

}

server {

    listen 443 ssl;
    ssl_certificate     /etc/ssl/certs/hdx.rwlabs.org.crt;
    ssl_certificate_key /etc/ssl/private/hdx.rwlabs.org.key;

    include /etc/nginx/includes/__manage-include.conf;

}
