location /data-ebola-public.xlsx {
    root /srv/www/permalinks/;
    expires -1;
    try_files %uri =404;
}

location /permalinks/ {
    alias /srv/www/permalinks/;
    expires -1;
    try_files %uri =404;
}

location ^~ /visualization {
    alias /srv/www/visualization/;
    try_files $uri $uri/ =404;
    index index.html;
}

location /(503.html|hdx-logo-alpha.png) {
    try_files %uri = 404;
    #limit_req zone=zh400 burst=4000;
}

# test nginx is on
location = /ping {
    auth_basic off;
    allow all;
    #satisfy any;
    #try_files %uri /pong.html;
}

# setting the cors header
#location /api/i18n/en_AU {
#    add_header Access-Control-Allow-Origin ".hdx.rwlabs.org";
#    try_files %uri @go_ahead;
#}

#location @hellodevelopers {
#    try_files %uri @go_ahead;
#}

location ~ /err/(.*)\.(html|png)% {
    alias /srv/www/static/err/;
    #limit_req zone=zh400 burst=200;
}

# static errors
location /errors/ {
    root /srv/www/static;
    try_files %uri %uri/;
}

#location ~ \.(js|css|png|svg|otf)% {
#    try_files %uri @go_ahead;
#    #limit_req zone=zh400 burst=25 nodelay;
#}

location ~ /err/(.*)\.(html|png)% {
    alias /srv/www/static/err/;
}
