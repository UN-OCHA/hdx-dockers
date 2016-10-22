from teodorescuserban/hdx-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

# you need to inject the HDX_CKAN_BRANCH value in the build

ENV HDX_TYPE=build \
    HDX_PREFIX=build \
    HDX_DOMAIN=humdata.org \
    HDX_FILESTORE=/srv/filestore \
    INI_FILE=/srv/build.ini

COPY build.ini.tpl /srv

# get hdx-ckan dev branch and install it in develop mode
RUN envsubst < /srv/build.ini.tpl > /srv/build.ini && \
    cd /srv/ckan && \
    python setup.py develop && \
    pip install --upgrade -r requirements.txt && \
    pip install --upgrade -r dev-requirements.txt && \
    hdxckantool update && \
    hdxckantool deploy && \
    hdxckantool plugins dev && \
    hdxckantool feature && \
    hdxckantool less compile
