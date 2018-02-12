# Hadoop

The following guide explains how to provision a Multi Node Hadoop Cluster locally and play with it. Checkout the [Vagrantfile](https://github.com/niqdev/devops-lab/blob/master/hadoop/Vagrantfile) and the Vagrant [guide](other/#vagrant) for more details.

### Directory structure

All the commands are executed in this directory `cd hadoop`

```bash
TODO
```

### Setup

Requirements

* Vagrant
* VirtualBox

Import the script
```bash
source vagrant_hadoop.sh
```

Create and start a Multi Node Hadoop Cluster
```bash
hadoop-start
```
*The first time it might take a while*

Access the cluster via ssh, check also the [/etc/hosts](https://github.com/niqdev/devops-lab/blob/master/hadoop/file/hadoop/hosts) file
```bash
vagrant ssh master
ssh hadoop@172.16.0.10 -i .data/hadoop_rsa

# 3 nodes
vagrant ssh node-1
ssh hadoop@172.16.0.101 -i .data/hadoop_rsa
```

Destroy the cluster
```bash
hadoop-destroy
```

Useful paths
```bash
# data and logs
/vol/hadoop
# (local) config
/usr/local/hadoop/etc/hadoop
# (hdfs) map-reduce history
/mr-history/history/done_intermediate/hadoop
# (hdfs) aggregated app logs
/yarn/app/hadoop/logs/application_XXX
```

## Web UI links

* NameNode: [http://namenode:50070](http://172.16.0.10:50070)
* NameNode metrics: [http://namenode:50070/jmx](http://172.16.0.10:50070/jmx)
* ResourceManager: [http://resource-manager:8088](http://172.16.0.10:8088)
* Log Level: [http://resource-manager:8088/logLevel](http://172.16.0.10:8088/logLevel)
* JVM stack traces: [http://resource-manager:8088/stacks](http://172.16.0.10:8088/stacks)
* Web Application Proxy Server: [http://web-proxy:8100/proxy/application_XXX_0000](http://172.16.0.10:8100/proxy/application_XXX_0000)
* MapReduce Job History Server: [http://history:19888](http://172.16.0.10:19888)
* DataNode/NodeManager (1): [http://node-1:8042/node](http://172.16.0.101:8042/node)
* DataNode/NodeManager (2): [http://node-2:8042/node](http://172.16.0.102:8042/node)
* DataNode/NodeManager (3): [http://node-3:8042/node](http://172.16.0.103:8042/node)

## HDFS and MapReduce

> **HDFS** is a distributed file system that provides high-throughput access to application data

> **YARN** is a framework for job scheduling and cluster resource management

> **MapReduce** is a YARN-based system for parallel processing of large data sets

Documentation

* [Hadoop v2.7.5](http://hadoop.apache.org/docs/r2.7.5)
* [Untangling Apache Hadoop YARN](http://blog.cloudera.com/blog/2015/09/untangling-apache-hadoop-yarn-part-1/) series

### HDFS Admin

```bash
# filesystem statistics
hdfs dfsadmin -report

# filesystem check
hdfs fsck /
```

### MapReduce WordCount Job

```bash
# create base directory using hdfs
hdfs dfs -mkdir -p /user/ubuntu

# create example directory
hadoop fs -mkdir -p /user/ubuntu/word-count/input

# list directory
hadoop fs -ls -h -R /
hadoop fs -ls -h -R /user/ubuntu

# create sample files
echo "Hello World Bye World" > file01
echo "Hello Hadoop Goodbye Hadoop" > file02

# copy from local to hdfs
hadoop fs -copyFromLocal file01 /user/ubuntu/word-count/input
hadoop fs -put file02 /user/ubuntu/word-count/input

# verify copied files
hadoop fs -ls -h -R /user/ubuntu
hadoop fs -cat /user/ubuntu/word-count/input/file01
hadoop fs -cat /user/ubuntu/word-count/input/file02
hadoop fs -cat /user/ubuntu/word-count/input/*

# build the jar (outside the machine to avoid permission issues)
cd devops-lab/hadoop/example/map-reduce
./gradlew clean build

# run application
hadoop jar /vagrant/example/map-reduce/build/libs/map-reduce.jar \
  /user/ubuntu/word-count/input \
  /user/ubuntu/word-count/output

# check output
hadoop fs -cat /user/ubuntu/word-count/output/part-r-00000

# delete directory to run it again
hadoop fs -rm -R /user/ubuntu/word-count/output

# run sample job in a different queue
hadoop jar \
  $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
  wordcount \
  -Dmapreduce.job.queuename=root.priority_queue \
  /user/ubuntu/word-count/input \
  /user/ubuntu/word-count/output

# well known WARN issue
# https://issues.apache.org/jira/browse/HDFS-10429
```

### Benchmarking MapReduce with TeraSort

```bash
# generate random data
hadoop jar \
  $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
  teragen 1000 random-data

# run terasort benchmark
hadoop jar \
  $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
  terasort random-data sorted-data

# validate data
hadoop jar \
  $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-*.jar \
  teravalidate sorted-data report

# useful commands
hadoop fs -ls -h -R .
hadoop fs -rm -r random-data
hadoop fs -cat random-data/part-m-00000
hadoop fs -cat sorted-data/part-r-00000
```

## Spark

> **Spark** is an open-source cluster-computing framework

TODO

## Flink

TODO

## Avro

> **Avro** is a data serialization system

TODO

## Parquet

> **Parquet** is a columnar storage format that can efficiently store nested data

TODO

## Flume

TODO

## Sqoop

TODO

## Pig

TODO

## Hive

TODO

## Crunch

TODO

## HBase

TODO

## Oozie

> **Oozie** is a workflow scheduler system to manage Hadoop jobs

Documentation

* [Oozie](https://oozie.apache.org)

### Setup

Oozie is not installed by default

```bash
# access master node
vagrant ssh master

# login as root
sudo su -

# build, install and init
/vagrant/script/setup_oozie.sh

# start oozie
su --login hadoop /vagrant/script/bootstrap.sh oozie
```
*It might take a while to build the sources*

Useful paths
```bash
# data and logs
/vol/oozie
# (local) config
/usr/local/oozie/conf
# (hdfs) examples
/oozie/examples
```

### Examples

TODO

## Ganglia

> **Ganglia** is a monitoring system for Hadoop

TODO

## Zeppelin

TODO

## Knox

TODO
