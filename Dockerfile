FROM teodorescuserban/hdx-base:stable

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apt-get -qq update

RUN apt-get -qq -y install \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    python-dev \
    python-pip

RUN mv /usr/local/lib/python2.7/dist-packages/requests /usr/local/lib/python2.7/dist-packages/requests.bak

RUN pip -q install --upgrade \
    gunicorn \
    lxml

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
