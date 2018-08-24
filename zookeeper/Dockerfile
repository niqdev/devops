FROM devops/base:latest
#FROM niqdev/phusion-base:latest

ARG VERSION=3.4.13

ENV ZOOKEEPER_HOME "/opt/zookeeper"
ENV PATH "$ZOOKEEPER_HOME/bin:$PATH"

RUN apt-get install -y \
  telnet \
  netcat && \
  apt-get clean

# version 3.5.x ERROR not in gzip format: use "tar -xf"
RUN curl https://www-eu.apache.org/dist/zookeeper/zookeeper-${VERSION}/zookeeper-${VERSION}.tar.gz | tar -xzf - -C /opt && \
  ln -s /opt/zookeeper-${VERSION} /opt/zookeeper && \
  mkdir -p /var/log/zookeeper /var/lib/zookeeper/data

ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD supervisor.ini /etc/supervisor/conf.d/zookeeper.conf
