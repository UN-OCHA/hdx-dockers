FROM teodorescuserban/hdx-base-fpm:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

# change the default by base-fpm
RUN mkdir -p /etc/service/fpm
ADD run /etc/service/fpm/run
RUN chmod +x /etc/service/fpm/run

# tweak php-fpm.conf and configure our pool (getting rid of the default one)
RUN mv /etc/php5/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.orig && \
    mv /etc/php5/fpm/pool.d/www.conf /etc/php5/fpm/pool.d/www.orig
ADD php-fpm.conf /etc/php5/fpm/
ADD hdx.conf /etc/php5/fpm/pool.d/
ADD test.php /srv/
ADD add_a_blank_wordpress.sh /srv/
ADD hdxblogtool.sh /srv/
RUN chmod +x /srv/hdxblogtool.sh && \
    ln -s /srv/hdxblogtool.sh /usr/local/sbin/hdxblogtool && \
    sed -i 's/.*date.timezone =.*/date\.timezone = UTC/'                    /etc/php5/fpm/php.ini && \
    sed -i 's/.*error_log =.*/error_log = syslog/'                          /etc/php5/fpm/php.ini && \
    sed -i 's/.*cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/'                    /etc/php5/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g"             /etc/php5/fpm/php.ini

EXPOSE 9000

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
