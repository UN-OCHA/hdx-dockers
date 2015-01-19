from teodorescuserban/hdx-base-tomcat:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update
RUN apt-get install -qq -y \
    postgresql-client-9.3

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV HDX_FOLDER /srv/hdx
RUN mkdir -p /srv/deploy /srv/backup
