FROM jenkins

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

USER root

RUN add-apt-repository ppa:tanguy-patte/phantomjs && \
    apt-get -qq update && \
    apt-get install -qq -y \
        git \
        libpq-dev \
        libyaml-dev \
        mc \
        nodejs \
        npm \
        phantomjs \
        postgresql-client-9.3 \
        python-pip \
        python-psycopg2 \
        python-dev \
        python-nose \
        python-coverage \
        python-nosexcover \
        software-properties-common && \
    npm install -g less && \
    npm install -g capturejs && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/jenkins_home/jobs/HDX/workspace && \
    curl -s -o /var/jenkins_home/jobs/HDX/workspace/hdxckantool.py https://bitbucket.org/teodorescuserban/hdx-tools/raw/master/hdxckantool.py

COPY hdx-test-core.ini /var/jenkins_home/jobs/HDX/workspace/
