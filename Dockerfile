FROM phusion/baseimage:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD locale /etc/default/locale
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

RUN apt-get -qq update
RUN apt-get -qq -y dist-upgrade
RUN apt-get -qq -y install \
    nano \
    telnet \
    python-software-properties \
    software-properties-common \
    git \
    build-essential

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
