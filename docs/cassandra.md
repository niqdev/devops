# Cassandra

> **Cassandra** is a distributed database for managing large amounts of structured data across many commodity servers, while providing highly available service and no single point of failure

Documentation

* [Cassandra](https://cassandra.apache.org)

```bash
TODO

########## cassandra ##########

docker-compose up
docker exec -it cassandra bash
docker exec -it cassandra bash -c cqlsh

# paths
/etc/cassandra
/var/lib/cassandra
/var/log/cassandra

# execute cql from host
(docker exec -i cassandra bash -c "cat > EXAMPLE.cql; cqlsh -f EXAMPLE.cql") < PATH/TO/EXAMPLE.cql

docker rm -fv cassandra
```

<br>
