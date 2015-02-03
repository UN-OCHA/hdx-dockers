FROM teodorescuserban/hdx-base-mysql:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV MYSQL_DIR /srv/db
ENV MYSQL_ROOT_PASS pass
ENV MYSQL_DB blog
ENV MYSQL_USER blog
ENV MYSQL_PASS blog

RUN mkdir -p /etc/service/mysql
ADD run /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run

RUN sed -i 's/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/my.cnf && \
    mkdir -p /srv/db && ls -l /srv  && \
    sed -i 's/^datadir\s*.*/datadir = \/srv\/db/' /etc/mysql/my.cnf

EXPOSE 3306

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

VOLUME ["/srv/db"]

CMD ["/sbin/my_init"]
