FROM node:6.9.5-wheezy
RUN apt-get -qq -y update
RUN apt-get -qq -y install mc
# FOR WATCHMAN
RUN apt-get -qq -y install python-dev
RUN git clone https://github.com/facebook/watchman.git
RUN cd watchman && git checkout v4.7.0 && ./autogen.sh && ./configure && make && make install
RUN apt-get -qq -y install gettext

RUN npm install -g npm@3.10.3 && npm install -g angular-cli

COPY my_docker_start.sh /bin/
RUN chmod +x /bin/my_docker_start.sh
