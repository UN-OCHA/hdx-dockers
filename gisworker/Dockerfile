FROM teodorescuserban/hdx-gislayer:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN touch /etc/servixe/gislayer/down
RUN mkdir -p /etc/service/gisworker
COPY run /etc/service/gisworker/
RUN chmod +x /etc/service/gisworker/run
