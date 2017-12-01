# provision-tools

```
docker build -t provision/base ./base
docker-compose -f docker-compose-local.yml up
docker exec -it zookeeper-local bash
docker exec -it kafka-local bash
```
