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
