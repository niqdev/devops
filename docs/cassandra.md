# Cassandra

> **Cassandra** is a distributed database for managing large amounts of structured data across many commodity servers, while providing highly available service and no single point of failure

Useful documentation

* [Cassandra](https://cassandra.apache.org)

* [A Decentralized Structured Storage System](https://www.cs.cornell.edu/projects/ladis2009/papers/lakshman-ladis2009.pdf) (Paper)

* [A Big Data Modeling Methodology for Apache Cassandra](https://pdfs.semanticscholar.org/22c6/740341ef13d3c5ee52044a4fbaad911f7322.pdf) (Paper)

* [Facebook’s Cassandra paper](https://docs.datastax.com/en/articles/cassandra/cassandrathenandnow.html)

* [Cassandra Data Modeling Best Practices](https://www.ebayinc.com/stories/blogs/tech/cassandra-data-modeling-best-practices-part-1)

<!-- * [Cassandra Modeling Kata](https://github.com/allegro/cassandra-modeling-kata) -->

Cassandra uses a tick-tock release model, even-numbered releases are feature releases, while odd-numbered releases are focused on bug fixes

## Setup

Single Node Cluster
```bash
# change path
cd devops/cassandra

# start single node
docker-compose up

# paths
/etc/cassandra
/var/lib/cassandra
/var/log/cassandra

# remove container and volume
docker rm -fv devops-cassandra
```

Multi Node Cluster
```bash
# change path
cd devops/cassandra

# start node
docker-compose -f docker-compose-cluster.yml up

# optional mounted volumes
mkdir -p \
  .cassandra/cassandra-seed/{data,log} \
  .cassandra/cassandra-node-1/{data,log} \
  .cassandra/cassandra-node-2/{data,log}
tree .cassandra/

# ISSUES releated to host permissions
# > Small commitlog volume detected at /var/lib/cassandra/commitlog
# > There is insufficient memory for the Java Runtime Environment to continue
(cassandra) /var/lib/cassandra
(root) /var/log/cassandra
```

Access container
```bash
# access container
docker exec -it devops-cassandra bash
docker exec -it devops-cassandra bash -c cqlsh
docker exec -it devops-cassandra-seed bash
docker exec -it devops-cassandra-node-1 bash

# execute cql script from host
(docker exec -i devops-cassandra bash \
  -c "cat > example.cql; cqlsh -f example.cql") < cql/example_create.cql
```

## Examples

`cqlsh` example [scripts](https://github.com/niqdev/devops/tree/master/cassandra/cql)

```bash
# connect
cqlsh localhost 9042
cqlsh localhost 9042 -u cassandra -p cassandra

# execute cql script
cqlsh -f cql/example_create.cql

# info
SHOW VERSION;
DESCRIBE CLUSTER;
DESCRIBE KEYSPACES;
DESCRIBE KEYSPACE example;
DESCRIBE TABLE example.messages;
```

Old `cassandra-cli` deprecated and removed in Cassandra 3.0

```
USE keyspace_name;
LIST table_name;
GET table_name["primary_key"];
SET table_name["primary_key"]["column_name"];
```

<br>
