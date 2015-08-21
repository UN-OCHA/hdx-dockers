from teodorescuserban/hdx-base-cps:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mkdir -p /srv/deploy /srv/backup && \
    rm -rf /srv/deploy/cps && \
    git clone https://github.com/OCHA-DAP/DAP-System.git /srv/deploy/cps && \
    curl -s -o /srv/hdxcpstool.py https://bitbucket.org/teodorescuserban/hdx-tools/raw/master/hdxcpstool.py && \
    chmod +x /srv/hdxcpstool.py && \
    ln -s /srv/hdxcpstool.py /usr/sbin/hdxcpstool && \
    mkdir -p /srv/hdx/logs /srv/hdx/config /srv/hdx/staging /srv/hdx/reports && \
    mkdir -p /etc/service/cps

COPY cps_schema_0_5_16.plsql cps-initial-user.sql initdb.sh /srv/
COPY hdx-secret hdx-config.tpl log4j.xml.tpl /srv/hdx/config/

# create cps service
COPY run_cps /etc/service/cps/run
RUN chmod +x /etc/service/cps/run

VOLUME ["/srv/backup"]

EXPOSE 8080

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
