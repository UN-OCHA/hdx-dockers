from teodorescuserban/hdx-base-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

# not used ENV CKAN_BRANCH_OR_TAG dev
#v0.5.16
#stag

# add hdx-ckan swiss army knife
ADD hdxckantool.py /srv/
RUN chmod +x /srv/hdxckantool.py && \
    ln -s /srv/hdxckantool.py /usr/sbin/hdxckantool

# install hdx-ckan
#RUN pip install -e "git+https://github.com/OCHA-DAP/hdx-ckan.git@$CKAN_BRANCH_OR_TAG#egg=hdx-ckan"
#RUN pip install -r https://raw.githubusercontent.com/OCHA-DAP/hdx-ckan/$CKAN_BRANCH_OR_TAG/requirements.txt

RUN git clone https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan
WORKDIR /srv/ckan

# already on dev
#RUN git fetch origin $CKAN_BRANCH && \
#    git checkout $CKAN_BRANCH && \
#    git pull origin $CKAN_BRANCH && \

RUN python setup.py develop && \
    pip install -r requirements.txt

# setup the plugins
RUN hdxckantool plugins dev

ADD gunicorn_conf.py /srv/
ADD prod.ini.tpl /srv/

ADD hdx-test-core.ini /srv/ckan/

RUN mkdir -p /etc/service/ckan
ADD run /etc/service/ckan/run
RUN chmod +x /etc/service/ckan/run

RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

VOLUME ["/srv/filestore", "/srv/backup", "/var/log/ckan"]

EXPOSE 9221

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
