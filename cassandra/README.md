## Cassandra

```
# list machines
docker-machine ls
# create machine
docker-machine create --driver virtualbox cassandra-cluster
# connect shell to the machine
eval "$(docker-machine env cassandra-cluster)"
# disconnect shell from the machine
eval $(docker-machine env -u)
# check ip
docker-machine ip cassandra-cluster
# help
docker-machine help

cd ~/Projects/provision-tools/cassandra

# optional
tree .cassandra
mkdir -p \
  .cassandra/cassandra-seed/{data,log} \
  .cassandra/cassandra-node-1/{data,log} \
  .cassandra/cassandra-node-2/{data,log}

# TODO check permissions
(cassandra) /var/lib/cassandra
(root) /var/log/cassandra

docker-compose -f docker-compose-cluster.yml up

docker-machine ssh cassandra-cluster
# TODO
docker exec -it cassandra-seed bash -c cqlsh

# ISSUE probably due to permissions
> Small commitlog volume detected at /var/lib/cassandra/commitlog
> There is insufficient memory for the Java Runtime Environment to continue.
```
