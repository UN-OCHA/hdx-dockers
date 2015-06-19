FROM teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get update && \
    apt-get install gdal-bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /srv && \
    cd /srv && \
    git clone https://bitbucket.org/agartner/gisrestlayer.git && \
    cd /srv/gisrestlayer && \
    pip install -r requirements.txt

RUN mkdir -p /etc/service/gislayer
ADD run /etc/service/gislayer/
RUN chmod +x /etc/service/gislayer/run

ADD pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

ADD app.conf /srv/

EXPOSE 5000
