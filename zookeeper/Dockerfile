FROM provision/base:latest

RUN apt-get install -y \
  telnet && \
  apt-get clean

RUN curl http://www-eu.apache.org/dist/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz | tar -xzf - -C /srv && \
  ln -s /srv/zookeeper-3.4.11 /srv/zookeeper && \
  mkdir -p /var/log/zookeeper /srv/zookeeper/data

ADD zoo.cfg /srv/zookeeper/conf/zoo.cfg
ADD supervisor.ini /etc/supervisor/conf.d/zookeeper.conf
