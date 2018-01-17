# hadoop-spark

```
cd hadoop-spark

vagrant up
vagrant ssh

# logs
/usr/local/hadoop/logs
# data
/var/hadoop
# config
/usr/local/hadoop/etc/hadoop
```

* NameNode http://localhost:50070
* ResourceManager http://localhost:8088

### HDFS

```

TODO
hadoop fs -mkdir -p /user/$USER

touch example.txt
hadoop fs -copyFromLocal touch example.txt hdfs://localhost/user/test/example.txt

# TODO
wget $URL_DOWNLOAD_BIN{.tar.gz,.tar.gz.md5} -P $TMP_DIRECTORY \
  && md5sum -c <<<"$(cat $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz.md5)  $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz"

```

* NameNode
* ResourceManager
* Web App Proxy Server
* MapReduce Job History server
* The rest of the machines in the cluster act as both DataNode and NodeManager:  these are the slaves

https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-hadoop-task-config.html

https://hortonworks.com/blog/introducing-apache-hadoop-yarn/

https://hortonworks.com/blog/apache-hadoop-yarn-resourcemanager/
http://www.dummies.com/programming/big-data/hadoop/master-nodes-in-hadoop-clusters/
https://ercoppa.github.io/HadoopInternals/HadoopArchitectureOverview.html
https://intellipaat.com/tutorial/hadoop-tutorial/mapreduce-yarn/
http://www.dbs.ifi.lmu.de/Lehre/BigData-Management&Analytics/WS15-16/Chapter-3_DFS_MapReduce_Hadoop_part2.pdf
http://hadoopinrealworld.com/namenode-and-datanode/
http://bigdataknowhow.weebly.com/blog/category/resource-manager
http://www.c2b2.co.uk/middleware-blog/hadoop-v2-overview-and-cluster-setup-on-amazon-ec2.php
https://www.quora.com/What-is-the-difference-between-Namenode-%2B-Datanode-Jobtracker-%2B-Tasktracker-Combiners-Shufflers-and-Mappers%2BReducers-in-their-technical-functionality-and-physically-ie-whether-they-are-on-the-same-machine-in-a-cluster-while-running-a-job

