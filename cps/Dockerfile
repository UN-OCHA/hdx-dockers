from teodorescuserban/hdx-base-cps:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

COPY cps_schema_0_5_16.plsql cps-initial-user.sql initdb.sh hdx-secret hdx-config.tpl log4j.xml.tpl run_cps helper_cps.py /srv/

ENV CPS_VERSION=tags/v0.15.1

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
        https://raw.githubusercontent.com/OCHA-DAP/hdx-tools/master/hdxcpstool.py && \
    chmod +x /srv/hdxcpstool.py && \
    ln -s /srv/hdxcpstool.py /usr/sbin/hdxcpstool && \
    cd /srv/deploy/cps/HDX-System && \
    git fetch && \
    git checkout $CPS_VERSION && \
    git pull origin $CPS_VERSION && \
    mvn clean && \
    mvn install -Dmaven.test.skip=true && \
    rm -rf /srv/tomcat/webapps/ROOT && \
    cp -a /srv/deploy/cps/HDX-System/target/hdx.war /srv/tomcat/webapps/ROOT.war && \
    mvn clean && \
    cd / && \
    rm -rf /srv/deploy/* && \
    apt-get -qq update && \
    apt-get -qq -y install libc-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/srv/backup", "/srv/tomcat/logs", "/srv/hdx/logs"]

EXPOSE 8080

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
