FROM teodorescuserban/hdx-base-python:stable

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

#ENV DEBIAN_FRONTEND noninteractive

RUN pip -q install --upgrade \
    json-table-schema

#RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

WORKDIR /srv/dataproxy

RUN git clone https://github.com/mbellotti/dataproxy.git /srv/dataproxy
RUN git checkout master
RUN git pull origin master
RUN git submodule init /srv/dataproxy/dataproxy
RUN git submodule update /srv/dataproxy/dataproxy

RUN mkdir -p /etc/service/dataproxy
ADD run /etc/service/dataproxy/run
RUN chmod +x /etc/service/dataproxy/run

RUN mkdir -p /srv/dataproxy /var/log/dataproxy
RUN touch /var/log/dataproxy/dataproxy.access.log touch /var/log/dataproxy/dataproxy.error.log
RUN chown -R www-data:www-data /var/log/dataproxy

ADD gunicorn_conf.py /srv/

EXPOSE 9223

CMD ["/sbin/my_init"]
