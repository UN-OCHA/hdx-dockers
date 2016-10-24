FROM teodorescuserban/hdx-cps:latest

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

# you need to inject the HDX_CPS_BRANCH value in the build

ARG HDX_CPS_BRANCH

ENV HDX_CPS_BRANCH=${HDX_CPS_BRANCH:-dev} \
    HDX_FOLDER=/srv/hdx

# get hdx-ckan dev branch and install it in develop mode
RUN mkdir -p /srv/deploy && \
    rm -rf /srv/deploy/cps && \
    git clone --depth 1 --branch ${HDX_CPS_BRANCH} \
        https://github.com/OCHA-DAP/DAP-System.git \
        /srv/deploy/cps && \
    cd /srv/deploy/cps && \
    mvn clean && \
    mvn install -Dmaven.test.skip=true && \
    rm -rf /srv/tomcat/webapps/* && \
    mv /srv/deploy/cps/HDX-System/target/hdx.war /srv/tomcat/webapps/ROOT.war && \
    mvn clean && \
    cd / && \
    rm -rf /srv/deploy/*
