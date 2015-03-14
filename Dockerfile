FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable && \
    apt-get -qq update && \
    apt-get -qq -y install nodejs npm gdal-bin && \
    npm install -g ogre && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    mkdir -p /src && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh

VOLUME ["/src"]

EXPOSE 3000

CMD ["/sbin/my_init"]
