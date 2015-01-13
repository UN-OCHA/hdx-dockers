from teodorescuserban/hdx-base-python:stable

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update
RUN apt-get install -qq -y \
    postgresql-client-9.3 \
    libpq-dev \
    python3-psycopg2

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p         /srv/ckan /var/log/ckan /srv/filestore
RUN chown www-data:www-data -R /var/log/ckan /srv/filestore
