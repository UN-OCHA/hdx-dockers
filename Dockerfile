FROM teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN cd /srv/spatial && \
    git clone https://bitbucket.org/agartner/gisrestlayer.git

EXPOSE 5000
