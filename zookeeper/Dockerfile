FROM phusion/baseimage:latest

ENV ZOOKEEPER_VERSION 3.4.11

RUN apt-get update && apt-get upgrade -y
RUN add-apt-repository ppa:openjdk-r/ppa -y

RUN apt-get update && apt-get install -y \
  python2.7 \
  python-pip \
  openjdk-8-jdk && \
  apt-get clean

#ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN pip install --upgrade pip wheel setuptools supervisor

RUN echo_supervisord_conf > /etc/supervisord.conf && \
  mkdir -p /etc/supervisor/conf.d && \
  sed -i -r ' \
    s/\;\[include\]/\[include\]/; \
    s/\;files = relative\/directory\/\*.ini/files = \/etc\/supervisor\/conf.d\/\*/; \
    ' /etc/supervisord.conf

RUN curl http://www-eu.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /srv && \
  ln -s /srv/zookeeper-${ZOOKEEPER_VERSION} /srv/zookeeper && \
  mkdir -p /srv/zookeeper/log /srv/zookeeper/data

ADD supervisor.ini /etc/supervisor/conf.d/zookeeper.conf
ADD zoo.cfg /srv/zookeeper/conf/zoo.cfg

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
