FROM node:6.9.5-wheezy
RUN apt-get -qq -y update
RUN apt-get -qq -y install mc git

RUN npm install -g grunt-cli bower yo

COPY my_docker_start.sh /bin/
RUN chmod +x /bin/my_docker_start.sh
