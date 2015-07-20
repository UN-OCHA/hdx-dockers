FROM teodorescuserban/hdx-base-gisapi:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#RUN echo "alias psql='psql -h db'" >> ~/.bashrc

COPY pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

RUN mkdir -p /etc/service/gisapi
COPY gisapi.run /etc/service/gisapi/run
RUN chmod +x /etc/service/gisapi/run

#install spatial
RUN mkdir -p /srv && \
    cd /srv && \
    git clone https://bitbucket.org/agartner/hdx-pgrestapi.git gisapi && \
    cd /srv/gisapi && \
    npm install

COPY settings.js.tpl /srv/gisapi/settings/

EXPOSE 80 5858
