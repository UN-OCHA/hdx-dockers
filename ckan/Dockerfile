from teodorescuserban/hdx-base-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mkdir -p /etc/service/ckan
ADD run /etc/service/ckan/run

# get hdx-ckan dev branch and install it in develop mode
RUN git clone https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan && \
    cd /srv/ckan && \
    python setup.py develop && \
    pip install -r requirements.txt

# add required files
ADD hdxckantool.py gunicorn_conf.py hdx-test-core.ini.tpl prod.ini.tpl /srv/
RUN chmod +x /srv/hdxckantool.py && \
    ln -s /srv/hdxckantool.py /usr/sbin/hdxckantool

# fix requests for pip
RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

VOLUME ["/srv/filestore", "/srv/backup", "/var/log/ckan"]

EXPOSE 9221

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
