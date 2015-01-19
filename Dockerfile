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
