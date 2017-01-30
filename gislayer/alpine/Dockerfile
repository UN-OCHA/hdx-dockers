FROM unocha/hdx-base-gislayer:alpine

COPY app.conf.tpl run_gislayer /srv/

RUN apk add --update-cache \
        python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    apk add \
        gettext \
        libpq && \
    apk add --virtual .build-deps \
        git \
        postgresql-dev \
        build-base \
        python-dev && \
    mkdir -p /srv && \
    cd /srv && \
    git clone https://bitbucket.org/agartner/gisrestlayer.git gislayer && \
    cd /srv/gislayer && \
    pip install -r requirements.txt && \
    pip install requests && \
    mkdir -p /etc/services.d/gislayer && \
    mv /srv/run_gislayer /etc/services.d/gislayer/run && \
    apk del \
        .build-deps \
        postgresql-dev \
        build-base \
        python-dev && \
    rm -rf /var/lib/apk/*
