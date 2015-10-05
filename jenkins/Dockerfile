FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV JENKINS_HOME /var/jenkins_home
ENV JENKINS_SLAVE_AGENT_PORT 50000
ENV JENKINS_VERSION 1.609.3
ENV JENKINS_SHA f5ad5f749c759da7e1a18b96be5db974f126b71e


#RUN echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
#RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
#RUN add-apt-repository -y ppa:webupd8team/java && \
#    apt-get -qq update && \
#    apt-get -qq -y install oracle-java7-installer oracle-java7-set-default maven && \

RUN apt-get -qq -y update && \
    apt-get -qq -y install \
        curl \
        default-jre-headless \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev \
        libyaml-dev \
        mc \
        nodejs \
        npm \
        postgresql-client-9.3 \
        python-coverage \
        python-dev \
        python-pip \
        python-psycopg2 \
        python-nose \
        python-nosexcover \
        python3-psycopg2 \
        software-properties-common \
        wget \
        zip \
        zlib1g-dev && \
    npm install -g less && \
    npm install -g capturejs && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    mkdir -p /var/jenkins_home/jobs/HDX/workspace && \
    curl -s -o /var/jenkins_home/jobs/HDX/workspace/hdxckantool.py https://bitbucket.org/teodorescuserban/hdx-tools/raw/master/hdxckantool.py && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh

COPY hdx-test-core.ini /var/jenkins_home/jobs/HDX/workspace/

RUN add-apt-repository ppa:tanguy-patte/phantomjs && \
    apt-get -qq update && \
    apt-get install -qq -y \
        phantomjs && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd -d "$JENKINS_HOME" -u 1000 -m -s /bin/bash jenkins
RUN mkdir -p /usr/share/jenkins/ref/init.groovy.d
COPY init.groovy /usr/share/jenkins/ref/init.groovy.d/tcp-slave-agent-port.groovy

#RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

VOLUME /var/jenkins_home


#ENV TINI_SHA 066ad710107dc7ee05d3aa6e4974f01dc98f3888

# Use tini as subreaper in Docker container to adopt zombie processes 
#RUN curl -fL https://github.com/krallin/tini/releases/download/v0.5.0/tini-static -o /bin/tini && chmod +x /bin/tini \
#  && echo "$TINI_SHA /bin/tini" | sha1sum -c -


# could use ADD but this one does not check Last-Modified header 
# see https://github.com/docker/docker/issues/8331
RUN curl -fL http://mirrors.jenkins-ci.org/war-stable/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war \
  && echo "$JENKINS_SHA /usr/share/jenkins/jenkins.war" | sha1sum -c -

ENV JENKINS_UC https://updates.jenkins-ci.org
RUN chown -R jenkins "$JENKINS_HOME" /usr/share/jenkins/ref

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 50000

ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log

USER jenkins

#COPY jenkins.sh /usr/local/bin/jenkins.sh
#ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]


CMD ["/sbin/my_init"]
