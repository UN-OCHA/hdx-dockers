FROM teodorescuserban/hdx-base-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update && \
    apt-get install -qq -y python3-requests && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/srv/filestore", "/srv/backup", "/srv/www", "/srv/logs"]

CMD ["/sbin/my_init"]
