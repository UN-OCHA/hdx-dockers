FROM unocha/alpine-base-s6:3.6

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apk add --update-cache \
        postfix \
        postfix-pcre \
        opendkim && \
    rm -rf /var/cache/apk/*
