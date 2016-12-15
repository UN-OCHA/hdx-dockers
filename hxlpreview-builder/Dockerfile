FROM unocha/alpine-nodejs-builder

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ENV SRC_DIR=/src \
    DST_DIR=/dst \
    NODE_PATH=/usr/lib/node_modules

COPY deploy.sh /srv/

RUN apk add --update \
        rsync \
        python \
        build-base && \
    npm install -g \
        npm@3.10.3 && \
    npm install -g \
        node-sass@^3.4.2 \
        angular-cli \
        angular && \
    rm -rf /var/lib/apk/* && \
    chmod +x /srv/deploy.sh

ENTRYPOINT ["/srv/deploy.sh"]

VOLUME ["$SRC_DIR", "$DST_DIR"]

CMD []
