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

# tweak php.ini
RUN sed -i 's/.*date.timezone =.*/date\.timezone = UTC/'                    /etc/php5/fpm/php.ini && \
    sed -i 's/.*expose_php =.*/expose_php = Off/'                           /etc/php5/fpm/php.ini && \
    sed -i 's/.*error_log =.*/error_log = syslog/'                          /etc/php5/fpm/php.ini && \
    sed -i 's/.*cgi.fix_pathinfo=.*/cgi.fix_pathinfo=0/'                    /etc/php5/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g"             /etc/php5/fpm/php.ini
# && \
#    sed -i -e "s/\s*short_open_tag\s*=//g"                              /etc/php5/fpm/php.ini && \
#    echo "short_open_tag = On"                                           >> /etc/php5/fpm/php.ini

# slap the latest wordpress in there
#RUN mkdir -p /srv/www/docs && \
#    curl https://wordpress.org/latest.tar.gz -so /srv/latest.tar.gz && \
#    tar xzf /srv/latest.tar.gz -C /srv/www/ && \
#    mv /srv/www/wordpress/* /srv/www/docs/ && \
#    rm /srv/latest.tar.gz && \
#    rm -rf /srv/www/wordpress

EXPOSE 80

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]
