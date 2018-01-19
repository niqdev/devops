# Provision Tools

A collection of Docker and Vagrant images mainly to provision distributed systems for local development and quick prototyping.

TODO
```
docker build -t provision/base ./base
docker-compose -f docker-compose-local.yml up

docker exec -it zookeeper-local bash
docker exec -it kafka-local bash
docker exec -it cassandra-local bash
```
