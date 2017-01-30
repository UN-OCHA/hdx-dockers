FROM unocha/alpine-base-s6:3.4

# echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories

ENV pkgver=2.1.0

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> \
        /etc/apk/repositories && \
    apk add --update-cache --virtual .build-deps \
        build-base \
        autoconf \
        automake \
        curl-dev \
        expat-dev \
        git \
        libtool \
        postgresql-dev \
        proj4-dev && \
    # installing kml libs \
    git clone https://github.com/google/libkml.git && \
    cd libkml && \
    ./autogen.sh  && \
    mkdir -p build  && \
    cd build  && \
    ../configure --prefix=/usr  && \
    make  && \
    make install  && \
    cd / && \
    rm -rf /libkml && \
    curl \
        http://download.osgeo.org/gdal/$pkgver/gdal-$pkgver.tar.gz \
        -o /gdal-$pkgver.tar.gz && \
    tar xvzf /gdal-$pkgver.tar.gz && \
    mv gdal-$pkgver gdal && \
    cd gdal && \
    ./configure --with-pg=/usr/bin/pg_config --prefix=/usr --with-libkml=yes && \
    make && \
    make install && \
    cd / && \
    rm -rf /gdal-$pkgver.tar.gz && \
    rm -rf /gdal && \
    apk del .build-deps && \
    apk add \
        proj4-dev\
        libstdc++ && \
    rm -rf /var/cache/apk/*
