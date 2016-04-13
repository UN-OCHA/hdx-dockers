FROM teodorescuserban/hdx-alpine-base:latest

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

COPY server.js node-run /tmp/

RUN apk update && \
    apk add git && \
    apk add nodejs==4.4.2-r0 --update-cache \
        --repository http://dl-3.alpinelinux.org/alpine/edge/main && \
    rm -rf /var/lib/apk/* && \
    npm install -g grunt-cli && \
    npm install -g bower && \
    mkdir -p /srv/www /etc/services.d/node && \
    mv /tmp/node-run /etc/services.d/node/run && \
    mv /tmp/server.js /srv/www/

#    adduser -h /srv/www -s /bin/sh www -g www -D

EXPOSE 3000

VOLUME ["/srv/www"]
