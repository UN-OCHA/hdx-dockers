FROM teodorescuserban/hdx-base:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN add-apt-repository ppa:nginx/stable && \
    apt-get -qq update && \
    apt-get install -qq -y \
        nginx-extras && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /etc/service/nginx && \
    echo -en '#!/bin/sh\nset -e\ncd /etc/nginx;\nexec /usr/sbin/nginx\n' > /etc/service/nginx/run && \
    chmod u+x /etc/service/nginx/run && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80 443

VOLUME ["/srv/www", "/var/log/nginx"]

CMD ["/sbin/my_init"]
