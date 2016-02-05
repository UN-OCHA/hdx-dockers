FROM teodorescuserban/hdx-base-nginx:1.8

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mv /etc/nginx /etc/nginx.original
COPY nginx /etc/nginx

COPY hdx.rwlabs.org.crt /etc/ssl/certs/

COPY run_nginx /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

EXPOSE 80 443

VOLUME ["/srv/www", "/var/log/nginx", "/etc/nginx", "/tmp"]

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
