FROM teodorescuserban/hdx-base-nginx:1.8

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

COPY hdx.rwlabs.org.crt run_nginx swup.py /srv/
RUN rm -rf /etc/nginx/*
COPY nginx /srv/nginx

RUN mv /srv/hdx.rwlabs.org.crt /etc/ssl/certs/ && \
    mv /srv/run_nginx /etc/service/nginx/run && \
    chmod +x /etc/service/nginx/run && \
    ln -sf /srv/swup.py /usr/sbin/swup

EXPOSE 80 443

VOLUME ["/srv/www", "/var/log/nginx", "/etc/nginx", "/tmp"]

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
