from teodorescuserban/hdx-base-ckan:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

COPY helper_ckan.py run_ckan gunicorn_conf.py hdx-test-core.ini.tpl prod.ini.tpl run_pgb pgb.ini.tpl pgb.users.tpl /srv/

# get hdx-ckan dev branch and install it in develop mode
RUN mkdir -p /var/log/ckan /srv/filestore /etc/service/ckan /srv/pgb /etc/service/pgb && \
    mv /srv/helper_ckan.py /srv/helper.py && \
    mv /srv/run_ckan /etc/service/ckan/run && \
    chmod +x /etc/service/ckan/run && \
    mv /srv/run_pgb /etc/service/pgb/run && \
    chmod +x /etc/service/pgb/run && \
    touch /srv/pgb/pgb.log && \
    touch /srv/pgb/pgb.pid && \
    chown -R postgres:postgres /srv/pgb && \
    mv /srv/pgb*.tpl /srv/pgb/ && \
    chown www-data:www-data -R /var/log/ckan /srv/filestore && \
    git clone https://github.com/OCHA-DAP/hdx-ckan.git /srv/ckan && \
    cd /srv/ckan && \
    python setup.py develop && \
    pip install -r requirements.txt && \
    pip install -r dev-requirements.txt && \
    curl -s -o /srv/hdxckantool.py https://bitbucket.org/teodorescuserban/hdx-tools/raw/master/hdxckantool.py && \
    chmod +x /srv/hdxckantool.py && \
    ln -s /srv/hdxckantool.py /usr/sbin/hdxckantool && \
    mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak && \
    apt-get -qq update && \
    apt-get -qq -y install pgbouncer \
        libc-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# add required files
#COPY gunicorn_conf.py hdx-test-core.ini.tpl prod.ini.tpl /srv/

VOLUME ["/srv/filestore", "/srv/backup", "/var/log/ckan"]

EXPOSE 5000

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
