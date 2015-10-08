from teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ADD msmtprc /etc/

RUN add-apt-repository ppa:tanguy-patte/phantomjs && \
    apt-get -qq update && \
    apt-get install -qq -y \
        postgresql-client-9.3 \
        libpq-dev \
        libyaml-dev \
        python3-psycopg2 \
        nodejs \
        npm \
        phantomjs && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g less && \
    npm install -g capturejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    if [ -e /usr/sbin/sendmail ]; then mv /usr/sbin/sendmail /usr/sbin/sendmail.orig; fi && \
    cd /usr/lib && ln -sf ../bin/msmtp sendmail && cd /usr/sbin && ln -sf ../bin/msmtp sendmail
