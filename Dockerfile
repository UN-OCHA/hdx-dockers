from teodorescuserban/hdx-base-cps:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV CPS_BRANCH tags/v0.6.5
ENV HDX_FOLDER /srv/hdx

###
# get and build cps

# clean-up
RUN rm -rf /srv/deploy/cps && \
    git clone https://github.com/OCHA-DAP/DAP-System.git /srv/deploy/cps

WORKDIR /srv/deploy/cps

RUN git fetch origin $CPS_BRANCH && \
    git checkout $CPS_BRANCH && \
    git pull origin $CPS_BRANCH

WORKDIR /srv/deploy/cps/HDX-System
RUN mvn clean && \
    mvn install -Dmaven.test.skip=true && \
    mv /srv/tomcat/webapps/ROOT /srv/tomcat/ROOT.orig && \
    rm -rf /srv/tomcat/webapps/hdx* && \
    rm -rf /srv/tomcat/webapps/ROOT* && \
    cp -af target/hdx.war /srv/tomcat/webapps/ROOT.war && \
    rm -rf /srv/deploy/cps/*

# add hdx-ckan swiss army knife
ADD hdxcpstool.py /srv/
RUN chmod +x /srv/hdxcpstool.py && \
    ln -s /srv/hdxcpstool.py /usr/sbin/hdxcpstool

# create tomcat admin pass
#ADD create_tomcat_admin_user.sh /srv/
#RUN chmod +x /srv/create_tomcat_admin_user.sh

# add postgres support 
# no need. added by Alex as dependency for cps build.
#RUN wget -nc -P $CATALINA_HOME/lib/ http://jdbc.postgresql.org/download/postgresql-9.3-1102.jdbc41.jar

# add tools to create an empty cps database (used copy to avoid unpacking)
COPY cps_schema_0_5_16.plsql /srv/
ADD cps-initial-user.sql /srv/cps-initial-user.sql
ADD initdb.sh /srv/

# configure hdx webapp 
RUN mkdir -p /srv/hdx/logs /srv/hdx/config /srv/hdx/staging /srv/hdx/reports
ADD hdx-secret /srv/hdx/config/
ADD hdx-config.tpl /srv/hdx/config/
ADD log4j.xml.tpl /srv/hdx/config/

# create cps service
RUN mkdir -p /etc/service/cps
ADD run /etc/service/cps/run
RUN chmod +x /etc/service/cps/run

VOLUME ["/srv/backup"]

EXPOSE 8080

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
