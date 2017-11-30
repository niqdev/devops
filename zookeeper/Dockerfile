FROM provision/base:latest

ARG VERSION=3.4.11

RUN apt-get install -y \
  telnet && \
  apt-get clean

RUN curl http://www-eu.apache.org/dist/zookeeper/zookeeper-${VERSION}/zookeeper-${VERSION}.tar.gz | tar -xzf - -C /opt && \
  ln -s /opt/zookeeper-${VERSION} /opt/zookeeper && \
  mkdir -p /var/log/zookeeper /var/lib/zookeeper/data

ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD supervisor.ini /etc/supervisor/conf.d/zookeeper.conf
