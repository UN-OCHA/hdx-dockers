FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Java
RUN apt-get -qq -y update
RUN apt-get -qq -y install \
    default-jre-headless \
    postgresql-client-9.3 \
    libpq-dev \
    python3-psycopg2 \
    nodejs npm \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    python-dev \
    python-pip

RUN npm install -g less
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD msmtprc /etc/
RUN if [ -e /usr/sbin/sendmail ]; then mv /usr/sbin/sendmail /usr/sbin/sendmail.orig; fi
RUN cd /usr/lib && ln -sf ../bin/msmtp sendmail && cd /usr/sbin && ln -sf ../bin/msmtp sendmail

#RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

RUN pip -q install --upgrade \
    gunicorn \
    gevent \
    lxml

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
