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
