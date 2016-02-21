FROM teodorescuserban/hdx-base-python:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN pip -q install --upgrade \
    json-table-schema

#RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

RUN mkdir -p /etc/service/dataproxy
ADD run /etc/service/dataproxy/run
RUN chmod +x /etc/service/dataproxy/run
ADD gunicorn_conf.py /srv/

WORKDIR /srv/dataproxy

RUN mkdir -p /srv/dataproxy /var/log/dataproxy && \
    touch /var/log/dataproxy/dataproxy.access.log && \
    touch /var/log/dataproxy/dataproxy.error.log && \
    chown -R www-data:www-data /var/log/dataproxy && \
    git clone https://github.com/mbellotti/dataproxy.git /srv/dataproxy && \
    git checkout master && \
    git pull origin master && \
    git submodule init /srv/dataproxy/dataproxy && \
    git submodule update /srv/dataproxy/dataproxy && \
    apt-get -qq update && apt-get -qq -y install libc-bin && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


EXPOSE 5000

CMD ["/sbin/my_init"]
