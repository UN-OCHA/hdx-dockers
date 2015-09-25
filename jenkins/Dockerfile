FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Java
RUN apt-get -qq -y update
RUN apt-get -qq -y install default-jre-headless

# Install Solr
ENV SOLR_HOME /srv/solr/example/solr
ENV SOLR_VERSION 4.8.1
ENV SOLR solr-$SOLR_VERSION
RUN mkdir -p /srv/solr
ADD https://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz /srv/$SOLR.tgz
RUN tar zxf /srv/$SOLR.tgz -C /srv/solr --strip-components 1

RUN rm -f /srv/$SOLR.tgz
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#EXPOSE 8983
#WORKDIR /srv/solr/example
#CMD ["java", "-jar", "start.jar"]
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
FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Java
RUN apt-get -qq -y update
RUN apt-get -qq -y install default-jre-headless

# Install Solr
ENV SOLR_HOME /srv/solr/example/solr
ENV SOLR_VERSION 4.8.1
ENV SOLR solr-$SOLR_VERSION
RUN mkdir -p /srv/solr
ADD https://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz /srv/$SOLR.tgz
RUN tar zxf /srv/$SOLR.tgz -C /srv/solr --strip-components 1

RUN rm -f /srv/$SOLR.tgz
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#EXPOSE 8983
#WORKDIR /srv/solr/example
#CMD ["java", "-jar", "start.jar"]
FROM teodorescuserban/hdx-base-solr:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Solr
ENV SOLR_HOME /srv/solr/example/solr
ENV SOLR_VERSION 4.8.1
ENV SOLR solr-$SOLR_VERSION

# Add CKAN Solr core
RUN cp -R $SOLR_HOME/collection1/ $SOLR_HOME/ckan/
RUN echo name=ckan > $SOLR_HOME/ckan/core.properties
ADD schema.xml $SOLR_HOME/ckan/conf/schema.xml
RUN mv $SOLR_HOME/solr.xml $SOLR_HOME/solr.xml.bak
ADD solr.xml $SOLR_HOME/solr.xml

RUN mkdir -p /etc/service/solr
ADD run /etc/service/solr/run
RUN chmod +x /etc/service/solr/run

EXPOSE 8983

WORKDIR /srv/solr/example

VOLUME ["/srv/solr/example/solr/ckan/data/"]

CMD ["/sbin/my_init"]

#!!!
#/srv/solr/example/logs - INFO level???
#/srv/solr/example/solr/ckan/data
FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update

RUN apt-get -qq -y install \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    python-dev \
    python-pip

#RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

RUN pip -q install --upgrade \
    gunicorn \
    gevent \
    lxml

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
