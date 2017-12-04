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

docker-compose -f docker-compose-cluster.yml up
```
