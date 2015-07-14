FROM teodorescuserban/hdx-base-gislayer:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mkdir -p /srv && \
    cd /srv && \
    git clone https://bitbucket.org/agartner/gisrestlayer.git gislayer && \
    cd /srv/gislayer && \
    pip install -r requirements.txt

RUN mkdir -p /etc/service/gislayer
COPY run /etc/service/gislayer/
RUN chmod +x /etc/service/gislayer/run

COPY pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

COPY app.conf /srv/
# just temporarily
COPY run_rqworker /srv/

EXPOSE 5000
