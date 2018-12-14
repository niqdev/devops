FROM devops/base:latest
#FROM niqdev/phusion-base:latest

ARG SCALA_VERSION=2.12
ARG KAFKA_VERSION=2.1.0

ENV ZOOKEEPER_HOSTS="localhost:2181"
ENV KAFKA_HOME "/opt/kafka"
ENV PATH "$KAFKA_HOME/bin:$PATH"

RUN apt-get install -y \
  kafkacat && \
  apt-get clean

RUN curl https://www-eu.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz | tar -xzf - -C /opt && \
  ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
  # bash expansion not working /var/log/{kafka,connect}
  mkdir -p /var/log/kafka /var/log/connect

# update data directory
RUN sed -i -r ' \
  s/log.dirs=\/tmp\/kafka-logs/log.dirs=\/var\/lib\/kafka\/data/; \
  ' /opt/kafka/config/server.properties

ADD supervisor-kafka.ini /etc/supervisor/conf.d/kafka.conf
ADD supervisor-connect.ini /etc/supervisor/conf.d/connect.conf
