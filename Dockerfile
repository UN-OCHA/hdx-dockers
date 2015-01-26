FROM teodorescuserban/hdx-base-nginx:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mv /etc/nginx /etc/nginx.original
ADD nginx /etc/nginx/

ADD hdx.rwlabs.org.crt /etc/ssl/certs/
ADD hdx.rwlabs.org.key /etc/ssl/private/
RUN chown root:root /etc/ssl/private/hdx.rwlabs.org.key
RUN chmod 400 /etc/ssl/private/hdx.rwlabs.org.key

EXPOSE 80
EXPOSE 443

VOLUME ['/srv/www', '/var/log/nginx']

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]
