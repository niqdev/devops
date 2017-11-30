FROM provision/base:latest

RUN apt-get install -y \
  telnet && \
  apt-get clean

RUN curl http://www-eu.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz | tar -xzf - -C /opt && \
  ln -s /opt/zookeeper-3.4.11 /opt/zookeeper && \
  mkdir -p /var/log/zookeeper /var/lib/zookeeper/data

ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg
ADD supervisor.ini /etc/supervisor/conf.d/zookeeper.conf
