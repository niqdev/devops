# Kafka

> **Kafka** is a distributed streaming platform

Documentation

* [Kafka](https://kafka.apache.org)

## Setup

Requirement

* [Base](docker/#base-image) image 
* [ZooKeeper](zookeeper) image

Build `devops/kafka` image
```bash
TODO

########## base + kafka ##########

cd kafka/
docker build -t provision/kafka .
# host:container
docker run --rm --name kafka -p 19092:9092 -e ZOOKEEPER_HOSTS="localhost:2181" provision/kafka
docker exec -it kafka bash

# paths
/opt/kafka
/opt/kafka/logs
/var/log/kafka
/var/lib/kafka/data

# test
cd /opt/kafka/bin
./kafka-topics.sh --create --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic test
./kafka-topics.sh --list --zookeeper zookeeper:2181
./kafka-console-producer.sh --broker-list kafka:9092 --topic test
./kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic test --from-beginning

# tutorial
https://kafka.apache.org/quickstart
https://hevodata.com/blog/how-to-set-up-kafka-on-ubuntu-16-04/

########## zookeeper + kafka ##########

docker network create --driver bridge my_network
docker network ls
docker network inspect my_network

docker run --rm \
  --name kafka \
  -p 19092:9092 \
  --network=my_network \
  -e ZOOKEEPER_HOSTS="zookeeper:2181" \
  provision/kafka

docker run --rm \
  --name zookeeper \
  -p 12181:2181 \
  --network=my_network \
  provision/zookeeper

apt-get install iputils-ping telnet -y
ping IP_V4_ADDRESS
```

<br>
