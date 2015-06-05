FROM teodorescuserban/hdx-base-pgrestapi:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#RUN echo "alias psql='psql -h db'" >> ~/.bashrc

COPY .pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

RUN mkdir -p /etc/service/gisapi
COPY gisapi.run /etc/service/gisapi/run
RUN chmod +x /etc/service/gisapi/run

#install spatial
RUN mkdir -p /srv/spatial
RUN cd /srv/spatial && \
    git clone https://bitbucket.org/agartner/hdx-pgrestapi.git && \
    cd hdx-pgrestapi && \
    npm install
COPY settings.js /srv/spatial/hdx-pgrestapi/settings/settings.js

EXPOSE 80 5858
