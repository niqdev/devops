FROM devops/base:latest

ARG SCALA_VERSION=2.12
ARG KAFKA_VERSION=1.0.0

ENV ZOOKEEPER_HOSTS="localhost:2181"

RUN curl https://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | tar -xzf - -C /opt && \
  ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
  mkdir -p /var/log/kafka

RUN sed -i -r ' \
  s/log.dirs=\/tmp\/kafka-logs/log.dirs=\/var\/lib\/kafka\/data/; \
  ' /opt/kafka/config/server.properties

ADD supervisor.ini /etc/supervisor/conf.d/kafka.conf
