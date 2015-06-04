FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable && \
    apt-get -qq update && \
    apt-get -qq -y install nodejs npm gdal-bin && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g nodemon && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh

# npm-install -g ogre


RUN apt-get -qq -y update
# && \
#    add-apt-repository ppa:mapnik/nightly-2.3 && \
#    apt-get -qq -y update && \
#    apt-get -qq -y install libmapnik && \
#        libmapnik-dev && \
#        mapnik-utils && \python-mapnik && \
#        mapnik-input-plugin-gdal && \
#        mapnik-input-plugin-postgis
#        # last 2 lines: also install datasource plugins if you need them



#RUN echo "alias psql='psql -h db'" >> ~/.bashrc

#COPY .pgpass /root/.pgpass
#RUN chmod 600 /root/.pgpass

# COPY mysetup.py /srv/
#ENV PYTHONPATH /srv/pysrc

#ADD myckancontainer_rsa.pub /tmp/myckancontainer_rsa.pub
#RUN cat /tmp/myckancontainer_rsa.pub >> /root/.ssh/authorized_keys && rm -f /tmp/myckancontainer_rsa.pub

#RUN chmod -x /etc/service/ckan/run
#RUN rm -rf /srv/ckan

#COPY ./sshd/ssh* /etc/ssh/
#RUN chmod 600 /etc/ssh/ssh_host*
#RUN rm /etc/service/sshd/down


#install spatial
RUN mkdir -p /srv/spatial
RUN cd /srv/spatial && \
    git clone https://bitbucket.org/agartner/hdx-pgrestapi.git && \
    cd hdx-pgrestapi && \
    npm install
#RUN cd /srv/spatial/hdx-pgrestapi/settings && cp settings.js.example settings.js
COPY settings.js /srv/spatial/hdx-pgrestapi/settings/settings.js

#install ogr2ogr
RUN apt-get -qq -y install gdal-bin
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80 5858
