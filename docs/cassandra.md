# Cassandra

> **Cassandra** is a distributed database for managing large amounts of structured data across many commodity servers, while providing highly available service and no single point of failure

Documentation

* [Cassandra](https://cassandra.apache.org)

## Setup

Single node cluster
```bash
# change path
cd devops/cassandra

# start single node
docker-compose up

# access container
docker exec -it devops-cassandra bash
docker exec -it devops-cassandra bash -c cqlsh

# execute cql from host
(docker exec -i cassandra bash \
  -c "cat > EXAMPLE.cql; cqlsh -f EXAMPLE.cql") < PATH/TO/EXAMPLE.cql

# paths
/etc/cassandra
/var/lib/cassandra
/var/log/cassandra

# remove container and volume
docker rm -fv devops-cassandra
```

<br>
