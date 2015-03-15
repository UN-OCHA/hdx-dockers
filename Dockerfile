FROM teodorescuserban/hdx-base-ogre:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN mkdir -p /etc/service/ogre /srv && \
    git clone https://github.com/OCHA-DAP/ogre.git /srv/ogre && \
    cd /srv/ogre && \
    npm install && \

ADD ogre.run /etc/service/ogre/run
RUN chmod +x /etc/service/ogre/run

VOLUME ["/srv", "/var/log"]

EXPOSE 3000

CMD ["/sbin/my_init"]
