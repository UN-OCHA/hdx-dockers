from teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update
RUN apt-get install -qq -y \
    postgresql-client-9.3 \
    libpq-dev \
    python3-psycopg2 \
    nodejs npm

RUN npm install -g less
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD msmtprc /etc/
RUN if [ -e /usr/sbin/sendmail ]; then mv /usr/sbin/sendmail /usr/sbin/sendmail.orig; fi
RUN cd /usr/lib && ln -sf ../bin/msmtp sendmail && cd /usr/sbin && ln -sf ../bin/msmtp sendmail

RUN mkdir -p         /srv/ckan /var/log/ckan /srv/filestore
RUN chown www-data:www-data -R /var/log/ckan /srv/filestore
