FROM teodorescuserban/hdx-base-psql:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

ENV POSTGRESQL_USER ckan
ENV POSTGRESQL_PASS ckan
ENV POSTGRESQL_DB ckan

RUN apt-get -qq -y update

RUN apt-get install -qq -y \
    postgis \
    postgresql-9.3-postgis-2.1

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cp -R /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.bak
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

RUN cp -R /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.bak
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

COPY .pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

RUN mkdir -p /srv/backup

RUN mkdir -p /srv/db
RUN chown postgres:postgres /srv/db
RUN sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /srv/db -E utf-8 --locale=en_US.UTF-8

ADD server.crt /srv/
ADD server.key /srv/
RUN chown postgres:postgres /srv/server.*
RUN chmod 640 /srv/server.key

#ADD psql_ckan_backup.sh /srv/
#RUN chmod +x /srv/psql_ckan_backup.sh

#RUN echo "02 02 * * * /srv/psql_ckan_backup.sh" | crontab -

RUN mkdir -p /etc/service/postgresql
ADD run /etc/service/postgresql/
RUN chmod +x /etc/service/postgresql/run

VOLUME ["/srv/db", "/srv/backup"]
EXPOSE 5432

CMD ["/sbin/my_init"]
