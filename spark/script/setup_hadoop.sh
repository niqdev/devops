#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup hadoop"

wget -P /tmp http://www-eu.apache.org/dist/hadoop/common/hadoop-2.7.5/hadoop-2.7.5.tar.gz

tar -xvzf /tmp/hadoop-2.7.5.tar.gz -C /opt

# export HADOOP_HOME=~/sw/hadoop-x.y.z
# export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

echo "[-] setup hadoop"
