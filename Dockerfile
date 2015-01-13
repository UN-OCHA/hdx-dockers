from teodorescuserban/hdx-base-ckan:stable

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV CKAN_BRANCH tags/v0.5.14

#RUN pip -q install --upgrade \
#    html5lib \
#    json-table-schema

RUN git clone https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan

WORKDIR /srv/ckan

RUN git fetch origin $CKAN_BRANCH
RUN git checkout $CKAN_BRANCH
RUN git pull origin $CKAN_BRANCH

RUN pip install -r requirements.txt

# setup
RUN python setup.py develop
RUN for p in $(ls -d ckanext-hdx*); do cd /srv/ckan/$p; python setup.py develop; done
RUN cd /srv/ckan/ckanext-sitemap; python setup.py develop

ADD gunicorn_conf.py /srv/
ADD prod.ini /srv/

ADD hdx-test-core.ini /srv/ckan/

ADD hdxckantool.py /srv/
RUN chmod +x /srv/hdxckantool.py
RUN ln -s /srv/hdxckantool.py /usr/sbin/hdxckantool

#RUN echo "02 02 * * * /srv/backup_ckan" | crontab -

RUN mkdir -p /etc/service/ckan
ADD run /etc/service/ckan/run
RUN chmod +x /etc/service/ckan/run

RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

VOLUME ["/srv/filestore", "/srv/backup", "/var/log/ckan"]
EXPOSE 9221

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

