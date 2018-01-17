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
