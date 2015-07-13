FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq -y install apt-transport-https && \
    curl https://repo.varnish-cache.org/GPG-key.txt | apt-key add - && \
    echo "deb https://repo.varnish-cache.org/ubuntu/ precise varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list && \
    apt-get -qq -y update && \
    apt-get -qq -y install varnish

ENV HDX_NGINX_HOST web
ENV HDX_NGINX_PORT 80
ENV LISTEN_ADDR 0.0.0.0:80
ENV CONFIG_FILE /etc/varnish/default.vcl
ENV DAEMON_USER varnish
ENV DAEMON_GROUP varnish
ENV STORAGE_BACKEND malloc,128M
ENV EXTRA_ARGS ''
ENV HDX_HTTPS_REDIRECT on

EXPOSE 80 6082

RUN mkdir -p /etc/service/varnish
COPY varnish.run /etc/service/varnish/run
RUN chmod +x /etc/service/varnish/run

COPY default.vcl.tpl /etc/varnish/
