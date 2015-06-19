FROM teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#RUN add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable && \
RUN add-apt-repository ppa:mapnik/nightly-2.3 && \
    apt-get -qq update && \
    apt-get -qq -y install \
        gdal-bin \
        postgresql-client-9.3 \
        libmapnik \
        libmapnik-dev \
        mapnik-utils \
        python-mapnik \
        mapnik-input-plugin-gdal \
        mapnik-input-plugin-postgis && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh
