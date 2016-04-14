FROM teodorescuserban/hdx-alpine-base-nodejs:latest

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ENV SRC_DIR=/src DST_DIR=/srv/www

COPY deploy.sh /

RUN apk update && \
    apk add rsync && \
    rm -rf /var/lib/apk/* && \
    adduser -h /src -s /bin/sh www-data -g www-data -D && \
    chmod +x /deploy.sh

ENTRYPOINT ["/init"]

EXPOSE 9000

VOLUME ["$SRC_DIR", "$DST_DIR"]

CMD []
