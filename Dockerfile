FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get -qq -y update

RUN apt-get install -qq -y \
    php5 \
    php5-mysql \
    mysql-client-5.5 \
    php5-fpm

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN sed -i 's/.*listen =.*/listen = 0.0.0.0:9000/'                             /etc/php5/fpm/pool.d/www.conf
#RUN sed -i 's/.*listen.allowed_clients =.*/listen.allowed_clients =/'          /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's/.*catch_workers_output =.*/catch_workers_output = yes/'          /etc/php5/fpm/pool.d/www.conf
RUN sed -i 's/;daemonize\s*=\s*yes/daemonize = no/'                            /etc/php5/fpm/php-fpm.conf
RUN sed -i 's/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/'     /etc/php5/fpm/pool.d/www.conf

RUN sed -i 's/.*date.timezone =.*/date\.timezone = UTC/'                    /etc/php5/fpm/php.ini
RUN sed -i 's/.*expose_php =.*/expose_php = Off/'                           /etc/php5/fpm/php.ini
RUN sed -i 's/.*error_log =.*/error_log = syslog/'                          /etc/php5/fpm/php.ini
RUN sed -i 's/.*cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/'                    /etc/php5/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g"             /etc/php5/fpm/php.ini

RUN mkdir -p /etc/service/fpm
ADD run /etc/service/fpm/run
RUN chmod +x /etc/service/fpm/run

EXPOSE 9000

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
