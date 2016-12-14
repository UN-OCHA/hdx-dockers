from teodorescuserban/hdx-base-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV HDX_CKAN_WORKERS=4

COPY helper_ckan.py run_ckan gunicorn_conf.py.tpl hdx-test-core.ini.tpl prod.ini.tpl run_pgb pgb.ini.tpl pgb.users.tpl /srv/

# get hdx-ckan dev branch and install it in develop mode
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    curl -s https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
    apt-get -qq update && \
    apt-get -qq -y install pgbouncer \
        libc-bin \
        imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /var/log/ckan /srv/filestore /etc/service/ckan /srv/pgb /etc/service/pgb && \
    mv /srv/helper_ckan.py /srv/helper.py && \
    mv /srv/run_ckan /etc/service/ckan/run && \
    chmod +x /etc/service/ckan/run && \
    chown www-data:www-data -R /var/log/ckan /srv/filestore && \
    mv /srv/run_pgb /etc/service/pgb/run && \
    chmod +x /etc/service/pgb/run && \
    chown -R postgres:postgres /srv/pgb && \
    echo "127.0.0.1:5432:pgbouncer:pgb:pgb" >> /root/.pgpass && \
    mv /srv/pgb*.tpl /srv/pgb/ && \
    git clone https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan && \
    cd /srv/ckan && \
    python setup.py develop && \
    pip install -r requirements.txt && \
    pip install -r dev-requirements.txt && \
    curl -s -o /srv/hdxckantool.py https://raw.githubusercontent.com/OCHA-DAP/hdx-tools/master/hdxckantool.py && \
    chmod +x /srv/hdxckantool.py && \
    ln -s /srv/hdxckantool.py /usr/sbin/hdxckantool && \
    mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak && \
    echo "application/vnd.geo+json                        geojson" >> /etc/mime.types && \
    pip install newrelic && \
    newrelic-admin generate-config LICENSE_KEY /srv/newrelic.ini

#    touch /srv/pgb/pgb.log && \
#    touch /srv/pgb/pgb.pid && \

VOLUME ["/srv/filestore", "/srv/backup", "/var/log/ckan"]

EXPOSE 5000

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
