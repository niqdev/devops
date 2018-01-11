# spark

```
cd spark

vagrant up
vagrant ssh
```

### HDFS

```
TODO config pseudodistributed mode
ll /usr/local/hadoop/etc/hadoop/

cp /usr/local/hadoop/etc/hadoop/core-site.xml /usr/local/hadoop/etc/hadoop/core-site.xml.orig

touch example.txt
hadoop fs -copyFromLocal touch example.txt hdfs://localhost/user/test/example.txt

wget $URL_DOWNLOAD_BIN{.tar.gz,.tar.gz.md5} -P $TMP_DIRECTORY \
  && md5sum -c <<<"$(cat $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz.md5)  $TMP_DIRECTORY/$FILE_NAME-bin.tar.gz"

yes | cp -rf $DIR_PROVISION/files/docker.conf /etc/systemd/system/docker.service.d/docker.conf
```

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html
