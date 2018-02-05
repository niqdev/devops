# Hadoop

TODO

## Directory structure

All the commands are executed in this directory `cd hadoop`

```bash
TODO
```

## Setup

Import the script
```bash
source vagrant_hadoop.sh
```

Create and start a Multi Node Hadoop Cluster
```bash
hadoop-start
```
*Note that the first time it could take a while*

Access the cluster
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

## HDFS and MapReduce

TODO


TODO

## Spark

TODO

## Flink

TODO

## Avro

TODO

## Parquet

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

TODO

## Ganglia

TODO

## Zeppelin

TODO

## Knox

TODO

<!--

> **HDFS** A distributed file system that provides high-throughput access to application data

> **YARN** A framework for job scheduling and cluster resource management

> **MapReduce** A YARN-based system for parallel processing of large data sets

> **Spark** An open-source cluster-computing framework

> **Avro** A data serialization system

> **Parquet** A columnar storage format that can efficiently store nested data

> **Oozie** A workflow scheduler system to manage Hadoop jobs

> **Ganglia** A monitoring system for Hadoop

Offical documentation

* [Hadoop](https://hadoop.apache.org)
* [Parquet](https://parquet.apache.org)
* [Oozie](https://oozie.apache.org)
* [Ganglia](http://ganglia.info)

Requirement

* Vagrant
* VirtualBox

The following guide explains how to provision a Single Node Hadoop Cluster locally and play with it. Checkout the [Vagrantfile](https://github.com/niqdev/provision-tools/blob/master/hadoop-spark/Vagrantfile) and the Vagrant [guide](other/#vagrant) for more details.

## Directory structure

All the commands are executed in this directory `cd hadoop-spark`

```bash
hadoop-spark/
├── example
│   └── map-reduce
│       ├── build
│       │   ...
│       │   └── libs
│       │      └── map-reduce.jar
│       ├── build.gradle
│       ├── gradlew
│       └── src
│           ├── main
│           │   └── java
│           │       └── com
│           │           └── github
│           │               └── niqdev
│           │                   ├── IntSumReducer.java
│           │                   ├── TokenizerMapper.java
│           │                   └── WordCount.java
│           └── test
│               └── ...
├── file
│   ├── hadoop-core-site.xml
│   ├── hadoop-hdfs-site.xml
│   ├── mapred-site.xml
│   ├── ssh-config
│   └── yarn-site.xml
├── README.md
├── script
│   ├── bootstrap.sh
│   ├── setup_all.sh
│   ├── setup_hadoop.sh
│   ├── setup_java.sh
│   ├── setup_spark.sh
│   ├── setup_user.sh
│   └── start_hadoop.sh
└── Vagrantfile
```

## Web UI

* namenode [http://localhost:50070](http://localhost:50070)
* resource manager [http://localhost:8088](http://localhost:8088)
* history server [http://localhost:19888](http://localhost:19888)
* set log level temporarily [http://localhost:8088/logLevel](http://localhost:8088/logLevel)
* JVM stack traces [http://localhost:8088/stacks](http://localhost:8088/stacks)
* namenode metrics [http://localhost:50070/jmx](http://localhost:50070/jmx)

## Setup

Start the box and verify the status
```bash
vagrant up
vagrant status
```
*Note that the first time it could take a while*

Access the box
```bash
vagrant ssh
```

Useful paths
```bash
# logs
/usr/local/hadoop/logs
# data
/var/hadoop
# config
/usr/local/hadoop/etc/hadoop
```

## HDFS

### Admin

```bash
# filesystem statistics
hdfs dfsadmin -report

# filesystem check
hdfs fsck /
```

## Example

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
cd provision-tools/hadoop-spark/example/map-reduce
./gradlew clean build

# run application
hadoop jar /vagrant/example/map-reduce/build/libs/map-reduce.jar \
  /user/ubuntu/word-count/input \
  /user/ubuntu/word-count/output

# check output
hadoop fs -cat /user/ubuntu/word-count/output/part-r-00000

# delete directory to run it again
hadoop fs -rm -R /user/ubuntu/word-count/output
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

### Spark Job

TODO

-->
