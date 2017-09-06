FROM alpine:3.6

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

RUN apk add --update-cache \
        nginx && \
    rm -rf /var/www && \
    mkdir -p /run/nginx /var/www && \
    rm -rf /var/cache/apk/*

WORKDIR /var/www

COPY cps .

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

VOLUME /var/log/nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
