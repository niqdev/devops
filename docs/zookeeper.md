# Zookeeper

ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services.

Documentation

* [ZooKeeper](https://zookeeper.apache.org/)

## Setup

Build `devops/base` image
```bash
# change path
cd devops/base
# build image
docker build -t devops/base .
```

Build `devops/zookeeper` image
```bash
# change path
cd devops/zookeeper

# build image
docker build -t devops/zookeeper:latest .
# build image with specific version
docker build -t devops/zookeeper:3.4.10 --build-arg VERSION=3.4.10 .

# temporary container host:container
docker run --rm --name zookeeper -p 12181:2181 devops/zookeeper
# access container
docker exec -it zookeeper bash

# paths
/opt/zookeeper
/var/log/zookeeper
/var/lib/zookeeper
/var/log/supervisord.log

# check zookeeper status
telnet localhost 2181
# expect answer imok
> ruok

# logs
tail -F /var/log/supervisord.log
# check service status
supervisorctl status
supervisorctl restart zookeeper
```

<br>
