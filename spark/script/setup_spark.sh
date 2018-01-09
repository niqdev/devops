#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

SPARK_VERSION="spark-2.2.1"
SPARK_PATH="$SPARK_VERSION-bin-hadoop2.7.tgz"

echo "[+] setup spark"

wget -P /tmp http://www-eu.apache.org/dist/spark/$SPARK_VERSION/$SPARK_PATH.tgz

tar -xvzf /tmp/$SPARK_PATH.tgz -C /opt
rm /tmp/$SPARK_PATH.tgz

sudo ln -s /opt/$SPARK_PATH /usr/local/spark

# TODO SPARK_HOME="/usr/local/spark"

# TODO verify signatures and checksums
# scala version ?

echo "[-] setup spark"
