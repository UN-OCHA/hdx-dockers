FROM alpine:3.5

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

RUN apk add --update --virtual .build-deps \
        build-base \
        git \
        nodejs-lts \
        rsync \
        ruby-bundler \
        ruby-dev \
        libffi-dev \
        python && \
    gem install --no-document \
        bootstrap-sass \
        font-awesome-sass \
        sass-globbing \
        compass && \
    rm -rf /var/cache/apk/* 
