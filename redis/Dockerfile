FROM teodorescuserban/hdx-base:latest

RUN apt-get -qq -y update && \
    apt-get -qq -y install mc && \
    apt-get -qq -y install redis-server && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /etc/service/redis

COPY redis.conf /etc/redis/redis.conf
ADD run /etc/service/redis/run
RUN chmod +x /etc/service/redis/run

EXPOSE 6379

CMD ["/sbin/my_init"]

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
