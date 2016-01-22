FROM teodorescuserban/hdx-base-solr:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

COPY run /srv/

RUN curl -s http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add - && \
    echo -e "\ndeb http://pkg.jenkins-ci.org/debian binary/\n" >> /etc/apt/sources.list
    apt-get -qq update && \
    apt-get -qq -y install jenkins && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /etc/service/jenkins && \
    mv /srv/run_jenkins /etc/service/jenkins/run && \
    chmod +x /etc/service/jenkins/run

EXPOSE 8080

#WORKDIR /srv/solr/example

#VOLUME ["/srv/solr/example/solr/ckan/data/"]

CMD ["/sbin/my_init"]
