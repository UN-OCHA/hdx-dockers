FROM teodorescuserban/hdx-nodejs-builder:latest

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ENV MPX_BRANCH=master

COPY deploy.sh /srv/

RUN chmod +x /srv/deploy.sh

ENTRYPOINT ["/srv/deploy.sh"]
