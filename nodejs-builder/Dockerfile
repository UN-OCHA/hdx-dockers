FROM unocha/alpine-nodejs-builder

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ENV SRC_DIR=/src \
    DST_DIR=/dst \
    NODE_PATH=/usr/lib/node_modules \
    NPM_CONFIG_PROGRESS=false \
    NPM_CONFIG_SPIN=false

RUN apk add --update \
        rsync \
        python \
        build-base && \
    npm install -g \
        npm@3.10.3 && \
    npm install -g --unsafe-perm \
        node-zopfli && \
    npm install -g \
        node-sass@^3.4.2 \
        angular-cli \
        angular && \
    rm -rf /var/lib/apk/*

#    # fix https://github.com/npm/npm/issues/13306 \
#    cd /usr/lib/node_modules/npm && \
#    npm install fs-extra && \
#    sed -i -e s/graceful-fs/fs-extra/ -e s/fs.rename/fs.move/ ./lib/utils/rename.js

ENTRYPOINT []

VOLUME ["$SRC_DIR", "$DST_DIR"]

CMD []
