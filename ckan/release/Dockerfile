FROM teodorescuserban/hdx-ckan:v3

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

# you need to inject the HDX_CKAN_BRANCH value in the build

ARG HDX_CKAN_BRANCH

ENV HDX_CKAN_BRANCH=${HDX_CKAN_BRANCH:-dev} \
    HDX_TYPE=build \
    HDX_PREFIX=build \
    HDX_DOMAIN=humdata.org \
    HDX_FILESTORE=/srv/filestore \
    INI_FILE=/srv/build.ini

COPY build.ini.tpl /srv

# get hdx-ckan dev branch and install it in develop mode
RUN envsubst < /srv/build.ini.tpl > /srv/build.ini && \
    rm -rf /srv/ckan && \
    git clone --depth 1 --branch ${HDX_CKAN_BRANCH} https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan && \
    cd /srv/ckan && \
    python setup.py develop && \
    pip install --upgrade -r requirements.txt && \
    pip install --upgrade -r dev-requirements.txt && \
    hdxckantool update && \
    hdxckantool plugins dev && \
    hdxckantool feature && \
    hdxckantool less compile

#    hdxckantool deploy && \
