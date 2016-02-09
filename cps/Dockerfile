from teodorescuserban/hdx-base-cps:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

COPY cps_schema_0_5_16.plsql cps-initial-user.sql initdb.sh hdx-secret hdx-config.tpl log4j.xml.tpl run_cps helper_cps.py/srv/

RUN mkdir -p /srv/deploy /srv/backup /etc/service/cps \
             /srv/hdx/logs /srv/hdx/config /srv/hdx/staging \
            /srv/hdx/reports && \
    rm -rf /srv/deploy/cps && \
    mv /srv/hdx-secret /srv/hdx/config && \
    mv /srv/hdx-config.tpl /srv/hdx/config && \
    mv /srv/log4j.xml.tpl /srv/hdx/config && \
    mv /srv/run_cps /etc/service/cps/run && \
    chmod +x /etc/service/cps/run && \
    git clone https://github.com/OCHA-DAP/DAP-System.git \
        /srv/deploy/cps && \
    curl -s -o /srv/hdxcpstool.py \
        https://bitbucket.org/teodorescuserban/hdx-tools/raw/master/hdxcpstool.py && \
    chmod +x /srv/hdxcpstool.py && \
    ln -s /srv/hdxcpstool.py /usr/sbin/hdxcpstool

VOLUME ["/srv/backup"]

EXPOSE 8080

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
