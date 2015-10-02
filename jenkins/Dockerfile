FROM jenkins

USER root

RUN apt-get -qq -y update && \
    apt-get -qq -y install \
        libpq-dev \
        mc \
        python-pip \
        python-psycopg2 \
        python-dev \
        python-nose \
        python-coverage \
        python-nosexcover
