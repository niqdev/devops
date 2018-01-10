#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup spark"

SPARK_VERSION="2.2.1"
HADOOP_VERSION="2.7"
SPARK_PATH="spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION"
SPARK_DIST="$SPARK_PATH.tgz"

wget -q -P /tmp "http://www-eu.apache.org/dist/spark/spark-$SPARK_VERSION/$SPARK_DIST"

tar -xvf /tmp/$SPARK_DIST -C /opt
rm /tmp/$SPARK_DIST

ln -s /opt/$SPARK_PATH /usr/local/spark

#echo -e "SPARK_HOME=/usr/local/spark\nPATH=\$PATH:\$SPARK_HOME/bin" | tee --append /etc/environment && \
#  source /etc/environment

#spark-shell --version

echo "[-] setup spark"
