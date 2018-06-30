# ZooKeeper

> **ZooKeeper** is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services

Resources

* [Documentation](https://zookeeper.apache.org)

* [Curator](https://curator.apache.org)

## Setup

Requirements

* [Base](docker/#base-image) image

Build `devops/zookeeper` image
```bash
# change path
cd devops/zookeeper

# build image
docker build -t devops/zookeeper:latest .
# build image with specific version - see Dockerfile for version 3.5.x
docker build -t devops/zookeeper:3.4.10 --build-arg VERSION=3.4.10 .

# temporary container [host:container]
docker run --rm --name zookeeper -p 12181:2181 devops/zookeeper
# access container
docker exec -it zookeeper bash

# paths
/opt/zookeeper
/var/log/zookeeper
/var/lib/zookeeper
/var/log/supervisord.log

# logs
tail -F /var/log/supervisord.log
# check service status
supervisorctl status
supervisorctl restart zookeeper
```

Example
```bash
docker exec -it zookeeper bash

# (option 1) check zookeeper status
echo ruok | nc localhost 2181

# (option 2) check zookeeper status
telnet localhost 2181
# expect answer imok
> ruok

zkCli.sh -server 127.0.0.1:2181
help
# list znodes
ls /
# create znode and associate value
create /zk_test my_data
# verify data
get /zk_test
# change value
set /zk_test junk
# delete znode
delete /zk_test
```

## The four-letter words

| Category | Command | Description |
| -------- |:-------:| ----------- |
| Server status | **ruok** | Prints *imok* if the server is running and not in an error state |
| | **conf** | Prints the server configuration (from zoo.cfg) |
| | **envi** | Prints the server environment, including ZooKeeper version, Java version, and other system properties |
| | **srvr** | Prints server statistics, including latency statistics, the number of znodes, and the server mode (standalone, leader, or follower) |
| | **stat** | Prints server statistics and connected clients |
| | **srst** | Resets server statistics |
| | **isro** | Shows whether the server is in read-only ( ro ) mode (due to a network partition) or read/write mode (rw) |
| Client connections | **dump** | Lists all the sessions and ephemeral znodes for the ensemble. You must connect to the leader (see srvr) for this command |
| | **cons** | Lists connection statistics for all the server's clients |
| | **crst** | Resets connection statistics |
| Watches | **wchs** | Lists summary information for the server's watches |
| | **wchc** | Lists all the server's watches by connection, may impact server performance for a large number of watches |
| | **wchp** | Lists all the server’s watches by znode path, may impact server performance for a large number of watches |
| Monitoring | **mntr** | Lists server statistics in Java properties format, suitable as a source for monitoring systems such as Ganglia and Nagios |

<br>
