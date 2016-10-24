FROM unocha/alpine-jdk:openjdk-7

MAINTAINER "Serban Teodorescu <teodorescu.serban@gmail.com>"

ARG HDX_CPS_BRANCH

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre \
    TOMCAT_MAJOR_VERSION=7 \
    TOMCAT_MINOR_VERSION=7.0.72 \
    CATALINA_HOME=/srv/tomcat \
    PATH=$CATALINA_HOME/bin:$PATH \
    MAVEN_VERSION=3.3.9 \
    HDX_CPS_BRANCH=${HDX_CPS_BRANCH:-dev} \
    HDX_FOLDER=/srv/hdx

COPY files/* /srv/

RUN apk add --update-cache openssl tar && \
    # install tomcat \
    mkdir -p /srv/tomcat && \
    curl -fsSL https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz \
        | tar -zxC /srv/tomcat --strip-components=1 && \
    # prepare to build cps \
    apk add --update-cache bash && \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
        | tar -xzC /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    # get and build cps \
    apk add --update-cache git openjdk7 && \
    mkdir -p /src && \
    rm -rf /src/* && \
    git clone --depth 1 --branch ${HDX_CPS_BRANCH} \
        https://github.com/OCHA-DAP/DAP-System.git \
        /src/cps && \
    cd /src/cps/HDX-System && \
    echo "building cps..." && \
    mvn clean -q && \
    mvn install -q -Dmaven.test.skip=true && \
    rm -rf /srv/tomcat/webapps/* && \
    mv /src/cps/HDX-System/target/hdx.war /srv/tomcat/webapps/ROOT.war && \
    cd / && \
    # clean cps sources \
    rm -rf /src/* && \
    apk del git openjdk7 && \
    # clean maven \
    rm -rf /usr/share/maven && \
    rm -f //usr/bin/mvn && \
    rm -rf /root/.m2 && \
    apk del bash && \
    # clean tomcat
    apk del tar && \
    # configure cps service \
    apk add --update-cache gettext && \
    mkdir -p /srv/deploy /srv/backup /etc/services.d/cps \
        $HDX_FOLDER/logs $HDX_FOLDER/config $HDX_FOLDER/staging \
        $HDX_FOLDER/reports && \
    mv /srv/hdx-secret $HDX_FOLDER/config && \
    mv /srv/hdx-config.tpl $HDX_FOLDER/config && \
    mv /srv/log4j.xml.tpl $HDX_FOLDER/config && \
    mv /srv/run_cps /etc/services.d/cps/run && \
    # add hdxcpstool \
    curl -s -o /srv/hdxcpstool.py \
        https://raw.githubusercontent.com/OCHA-DAP/hdx-tools/master/hdxcpstool.py && \
    chmod +x /srv/hdxcpstool.py && \
    ln -s /srv/hdxcpstool.py /usr/sbin/hdxcpstool && \
    # clean alpine cache \
    rm -rf /var/cache/apk/*

VOLUME ["/srv/backup", "/srv/tomcat/logs", "/srv/hdx/logs"]

EXPOSE 8080
