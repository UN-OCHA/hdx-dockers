FROM teodorescuserban/hdx-base-solr:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

# Install Solr
ENV SOLR_HOME /srv/solr/example/solr
ENV SOLR_VERSION 4.8.1
ENV SOLR solr-$SOLR_VERSION
ENV IS_MASTER true
ENV IS_SLAVE false

COPY repl.xml run_solr solr.xml solrcore.properties /tmp/
ADD https://raw.githubusercontent.com/OCHA-DAP/hdx-ckan/97d56f2338eec7ee31126a058fcc0dcb2c92ed74/ckanext-hdx_search/ckanext/hdx_search/hdx-solr/schema.xml /tmp/schema.xml

RUN cp -R $SOLR_HOME/collection1/ $SOLR_HOME/ckan/ && \
    echo name=ckan > $SOLR_HOME/ckan/core.properties && \
    mv /tmp/schema.xml $SOLR_HOME/ckan/conf/schema.xml && \
    chmod 644 $SOLR_HOME/ckan/conf/schema.xml && \
    mv $SOLR_HOME/solr.xml $SOLR_HOME/solr.xml.bak && \
    mv /tmp/solr.xml $SOLR_HOME/solr.xml && \
    mkdir -p /etc/service/solr && \
    mv /tmp/run_solr /etc/service/solr/run && \
    chmod +x /etc/service/solr/run && \
    mv /tmp/solrcore.properties /srv/solr/example/solr/ckan/conf/ && \
    sed -i 's/<\/config>//' /srv/solr/example/solr/ckan/conf/solrconfig.xml && \
    cat /tmp/repl.xml >> /srv/solr/example/solr/ckan/conf/solrconfig.xml

# Add CKAN Solr core
#RUN cp -R $SOLR_HOME/collection1/ $SOLR_HOME/ckan/
#RUN echo name=ckan > $SOLR_HOME/ckan/core.properties
#ADD schema.xml $SOLR_HOME/ckan/conf/schema.xml
#RUN chmod 644 $SOLR_HOME/ckan/conf/schema.xml
#RUN mv $SOLR_HOME/solr.xml $SOLR_HOME/solr.xml.bak
#ADD solr.xml $SOLR_HOME/solr.xml

#RUN mkdir -p /etc/service/solr
#ADD run /etc/service/solr/run
#RUN chmod +x /etc/service/solr/run

EXPOSE 8983

WORKDIR /srv/solr/example

VOLUME ["/srv/solr/example/solr/ckan/data/"]

CMD ["/sbin/my_init"]

#!!!
#/srv/solr/example/logs - INFO level???
#/srv/solr/example/solr/ckan/data
