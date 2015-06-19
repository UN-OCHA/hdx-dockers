from teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV TOMCAT_MAJOR_VERSION 7
ENV TOMCAT_MINOR_VERSION 7.0.55
ENV CATALINA_HOME /srv/tomcat

# from base-oracle
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java && \
    apt-get -qq update && \
    apt-get -qq -y install oracle-java7-installer oracle-java7-set-default maven && \
    apt-get install -qq -y --no-install-recommends wget pwgen ca-certificates && \
    apt-get install -qq -y postgresql-client-9.3 python3-psycopg2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /tmp
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* /srv/tomcat


# from base-tomcat
#RUN apt-get -qq -y update && \
#    apt-get install -qq -y --no-install-recommends wget pwgen ca-certificates && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# INSTALL TOMCAT
#RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
#    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
#    tar zxf apache-tomcat-*.tar.gz && \
#    rm apache-tomcat-*.tar.gz && \
#    mv apache-tomcat* /srv/tomcat

#WORKDIR /tmp
#RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
#    wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
#    tar zxf apache-tomcat-*.tar.gz && \
#    rm apache-tomcat-*.tar.gz && \
#    mv apache-tomcat* /srv/tomcat

# from here
#RUN apt-get -qq update && \
#    apt-get install -qq -y postgresql-client-9.3 python3-psycopg2 && \
#    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
