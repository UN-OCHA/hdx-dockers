FROM teodorescuserban/hdx-base-pgrestapi:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#RUN echo "alias psql='psql -h db'" >> ~/.bashrc

COPY .pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

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
#RUN apt-get -qq -y install gdal-bin
# npm-install -g ogre

EXPOSE 80 5858
