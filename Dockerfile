FROM teodorescuserban/hdx-base:stable

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq -y update

RUN apt-get install -qq -y \
    postgresql-9.3 \
    postgresql-client-9.3 \
    postgresql-contrib-9.3
#    libpq-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

