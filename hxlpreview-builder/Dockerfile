FROM unocha/hdx-nodejs-builder

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ENV NODE_PATH=/usr/lib/node_modules \
    NPM_CONFIG_PROGRESS=false \
    NPM_CONFIG_SPIN=false

COPY deploy.sh /srv/

RUN  chmod +x /srv/deploy.sh

#    # fix https://github.com/npm/npm/issues/13306 \
#    cd /usr/lib/node_modules/npm && \
#    npm install fs-extra && \
#    sed -i -e s/graceful-fs/fs-extra/ -e s/fs.rename/fs.move/ ./lib/utils/rename.js

ENTRYPOINT ["/srv/deploy.sh"]

VOLUME ["$SRC_DIR", "$DST_DIR"]

CMD []
