# Cassandra

> **Cassandra** is a distributed database for managing large amounts of structured data across many commodity servers, while providing highly available service and no single point of failure

Documentation

* [Cassandra](https://cassandra.apache.org)

## Setup

Single Node Cluster
```bash
# change path
cd devops/cassandra

# start single node
docker-compose up

# access container
docker exec -it devops-cassandra bash
docker exec -it devops-cassandra bash -c cqlsh

# execute cql from host
(docker exec -i devops-cassandra bash \
  -c "cat > example.cql; cqlsh -f example.cql") < cql/example.cql

# paths
/etc/cassandra
/var/lib/cassandra
/var/log/cassandra

# remove container and volume
docker rm -fv devops-cassandra
```

Example
```bash
docker exec -it devops-cassandra bash -c cqlsh

DESCRIBE keyspaces;
DESCRIBE KEYSPACE example;
DESCRIBE TABLE example.messages;
SELECT * FROM example.messages;
```

<br>
