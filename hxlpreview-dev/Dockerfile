
FROM node:6.9.5-alpine
RUN apk update
RUN apk add mc
# FOR WATCHMAN
RUN apk add python-dev git automake autoconf g++ make linux-headers
RUN git clone https://github.com/facebook/watchman.git
RUN cd watchman && git checkout v4.7.0 && ./autogen.sh && ./configure && make && make install
RUN apk add gettext

RUN npm install -g npm@3.10.3 && npm install -g angular-cli

COPY my_docker_start.sh /bin/
RUN chmod +x /bin/my_docker_start.sh

