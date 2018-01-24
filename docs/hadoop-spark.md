# Hadoop and Spark

> **HDFS** A distributed file system that provides high-throughput access to application data

> **YARN** A framework for job scheduling and cluster resource management

> **MapReduce** A YARN-based system for parallel processing of large data sets

> **Spark** An open-source cluster-computing framework

> **Avro** A data serialization system

> **Oozie** A workflow scheduler system to manage Hadoop jobs

> **Ganglia** A monitoring system for Hadoop

## Example

### MapReduce Job

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

### Spark Job

TODO
