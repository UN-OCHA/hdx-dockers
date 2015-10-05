FROM teodorescuserban/hdx-base-psql:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive

ENV POSTGRESQL_USER ckan
ENV POSTGRESQL_PASS ckan
ENV POSTGRESQL_DB ckan
ENV POSTGRESQL_DATASTORE_USER datastore
ENV POSTGRESQL_DATASTORE_PASS datastore
ENV POSTGRESQL_DATASTORE_DB datastore

ENV POSTGRESQL_TEST_DB ckan_test
ENV POSTGRESQL_TEST_DB_DATASTORE datastore_test

RUN cp -R /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.bak
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

RUN cp -R /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.bak
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

RUN mkdir -p /srv/backup

RUN mkdir -p /srv/db
RUN chown postgres:postgres /srv/db
RUN sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /srv/db -E utf-8 --locale=en_US.UTF-8

ADD server.crt /srv/
ADD server.key /srv/
RUN chown postgres:postgres /srv/server.*
RUN chmod 640 /srv/server.key

ADD psql_ckan_backup.sh /srv/
RUN chmod +x /srv/psql_ckan_backup.sh

RUN echo "02 02 * * * /srv/psql_ckan_backup.sh" | crontab -

RUN mkdir -p /etc/service/postgresql
ADD run /etc/service/postgresql/
RUN chmod +x /etc/service/postgresql/run

VOLUME ["/srv/db", "/srv/backup"]
EXPOSE 5432

CMD ["/sbin/my_init"]
