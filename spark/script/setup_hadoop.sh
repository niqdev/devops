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

#???
sudo ln -s /opt/hadoop-2.7.5 /usr/local/hadoop

/opt/hadoop-2.7.5/bin/hadoop version

# echo "export HADOOP_HOME=/usr/local/hadoop" | sudo tee --append /etc/profile.d/hadoop.sh
# echo "export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin" | sudo tee --append /etc/profile.d/hadoop.sh

# export HADOOP_HOME=~/sw/hadoop-x.y.z
# export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

# https://www.digitalocean.com/community/tutorials/how-to-install-hadoop-in-stand-alone-mode-on-ubuntu-16-04
# http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/

echo "[-] setup hadoop"
