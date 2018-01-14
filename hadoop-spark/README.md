# hadoop-spark

```
cd hadoop-spark

vagrant up
vagrant ssh
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
