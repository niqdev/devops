# spark

```
cd spark

vagrant up
vagrant ssh
```

### HDFS

```

http://hadoop.apache.org/docs/r2.7.5/hadoop-project-dist/hadoop-common/SingleCluster.html

TODO config pseudodistributed mode
ll /usr/local/hadoop/etc/hadoop/

mv /usr/local/hadoop/etc/hadoop/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml.orig
cp /vagrant/file/hadoop-core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml

mv /usr/local/hadoop/etc/hadoop/hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml.orig
cp /vagrant/file/hadoop-hdfs-site.xml /usr/local/hadoop/etc/hadoop/hdfs-site.xml

# TODO yarn
hdfs namenode -format
start-dfs.sh
% start-yarn.sh
% mr-jobhistory-daemon.sh start historyserver
# jps ???
The following daemons will be started on your local machine: a namenode, a secondary
namenode, a datanode (HDFS), a resource manager, a node manager (YARN), and a
history server (MapReduce). You can check whether the daemons started successfully
by looking at the logfiles in the logs directory (in the Hadoop installation directory) or
by looking at the web UIs, at http://localhost:50070/ for the namenode, http://localhost:
8088/ for the resource manager, and http://localhost:19888/ for the history server. You
can also use Java’s jps command to see whether the processes are running.

% mr-jobhistory-daemon.sh stop historyserver
% stop-yarn.sh
% stop-dfs.sh
hadoop fs -mkdir -p /user/$USER

touch example.txt
hadoop fs -copyFromLocal touch example.txt hdfs://localhost/user/test/example.txt

wget $URL_DOWNLOAD_BIN{.tar.gz,.tar.gz.md5} -P $TMP_DIRECTORY \
  && md5sum -c <<<"$(cat $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz.md5)  $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz"

```

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html
