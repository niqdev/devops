#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup hadoop"

HADOOP_VERSION="2.7.5"
HADOOP_PATH="hadoop-$HADOOP_VERSION"
HADOOP_DIST="$HADOOP_PATH.tar.gz"

wget -q -P /tmp http://www-eu.apache.org/dist/hadoop/common/$HADOOP_PATH/$HADOOP_DIST

tar -xvzf /tmp/$HADOOP_DIST -C /opt
rm /tmp/$HADOOP_DIST

ln -s /opt/$HADOOP_PATH /usr/local/hadoop

echo -e "HADOOP_HOME=/usr/local/hadoop" | tee --append /etc/environment && \
  source /etc/environment

echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | tee --append /etc/profile.d/hadoop.sh && \
  source /etc/profile.d/hadoop.sh

hadoop version

echo "[-] setup hadoop"
