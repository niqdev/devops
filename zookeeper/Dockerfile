FROM phusion/baseimage:latest

ENV ZOOKEEPER_VERSION 3.4.11

RUN apt-get update && apt-get upgrade -y
RUN add-apt-repository ppa:openjdk-r/ppa -y

RUN apt-get update && apt-get install -y \
  openjdk-8-jdk && \
  apt-get clean

#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN curl http://www-eu.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /srv && \
  ln -s /srv/zookeeper-${ZOOKEEPER_VERSION} /srv/zookeeper && \
  mkdir -p /srv/zookeeper/log /srv/zookeeper/data

ADD zoo.cfg /srv/zookeeper/conf/zoo.cfg
