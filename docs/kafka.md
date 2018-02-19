# Kafka

> **Kafka** is a distributed streaming platform

Documentation

* [Kafka](https://kafka.apache.org)

## Setup

Requirement

* [Base](docker/#base-image) docker image 
* [ZooKeeper](zookeeper) docker image

Build `devops/kafka` image
```bash
# change path
cd devops/kafka

# build image
docker build -t devops/kafka .

# create network
docker network create --driver bridge my_network
docker network ls
docker network inspect my_network

# start temporary zookeeper container [host:container]
docker run --rm \
  --name zookeeper \
  -p 12181:2181 \
  --network=my_network \
  devops/zookeeper
# access container
docker exec -it zookeeper bash

# start temporary kafka container [host:container]
docker run --rm \
  --name kafka \
  -p 19092:9092 \
  --network=my_network \
  -e ZOOKEEPER_HOSTS="zookeeper:2181" \
  devops/kafka
# access container
docker exec -it kafka bash

# paths
/opt/kafka
/opt/kafka/logs
/var/log/kafka
/var/lib/kafka/data
```

Alternatively use compose
```bash
TODO
```

Example
```bash
docker exec -it kafka bash
cd /opt/kafka/bin

./kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic test
./kafka-topics.sh --list --zookeeper zookeeper:2181
./kafka-console-producer.sh --broker-list kafka:9092 --topic test
./kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic test --from-beginning
```

<br>
