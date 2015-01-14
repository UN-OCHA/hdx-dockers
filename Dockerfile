FROM teodorescuserban/hdx-base-psql:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#ENV DEBIAN_FRONTEND noninteractive

ENV POSTGRESQL_DB cps
ENV POSTGRESQL_USER cps
ENV POSTGRESQL_PASS cps

RUN cp -R /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.bak
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf

RUN cp -R /etc/postgresql/9.3/main/postgresql.conf /etc/postgresql/9.3/main/postgresql.conf.bak
ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf

# done in service run 
#RUN mkdir -p /srv/db
#RUN chown postgres:postgres /srv/db
#RUN sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D /srv/db -E utf-8 --locale=en_US.UTF-8

ADD server.crt /srv/
ADD server.key /srv/
RUN chown postgres:postgres /srv/server.*
RUN chmod 640 /srv/server.key

RUN mkdir -p /etc/service/postgresql
ADD run /etc/service/postgresql/
RUN chmod +x /etc/service/postgresql/run

ADD initdb.sh /srv/
ADD cps-0.5.1.sql /srv/

VOLUME ["/srv/db"]

EXPOSE 5432

CMD ["/sbin/my_init"]
