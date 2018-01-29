#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup hadoop"

FILE_PATH="/vagrant/file"
DATA_PATH="/vagrant/data"
VAGRANT_HOME="/home/vagrant"

HADOOP_VERSION="2.7.5"
HADOOP_NAME="hadoop-$HADOOP_VERSION"
HADOOP_DIST="$HADOOP_NAME.tar.gz"
HADOOP_TMP_PATH="$DATA_PATH/$HADOOP_DIST"

function download_dist {
  local HADOOP_MIRROR_DOWNLOAD="http://www-eu.apache.org/dist/hadoop/common/$HADOOP_NAME/$HADOOP_DIST"

  echo "[*] download dist"
  wget -q -P $DATA_PATH $HADOOP_MIRROR_DOWNLOAD
}

function setup_dist {
  if [ ! -e $HADOOP_TMP_PATH ]; then
    download_dist
  fi

  echo "[*] setup dist"
  tar -xzf $HADOOP_TMP_PATH -C /opt
  #rm $HADOOP_TMP_PATH
  ln -s /opt/$HADOOP_NAME /usr/local/hadoop
}

function update_env {
  echo "[*] update env"
  echo -e "HADOOP_HOME=/usr/local/hadoop" | tee --append /etc/environment && \
    source /etc/environment
  echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | tee --append /etc/profile.d/hadoop.sh && \
    source /etc/profile.d/hadoop.sh
}

function setup_config {
  echo "[*] create data directory"
  mkdir -p /var/hadoop/hadoop-datanode /var/hadoop/hadoop-namenode
  
  local CONFIG_PATH="$HADOOP_HOME/etc/hadoop"
  local FILES=( "core-site.xml" "hdfs-site.xml" )
  for FILE in "${FILES[@]}"
  do
    echo "[*] update config: $FILE"
    mv $CONFIG_PATH/$FILE $CONFIG_PATH/$FILE.orig
    cp $FILE_PATH/hadoop-$FILE $CONFIG_PATH/$FILE
  done
}

function setup_ssh {
  echo "[*] setup ssh"
  ssh-keygen -t rsa -P '' -f $VAGRANT_HOME/.ssh/id_rsa
  cat $VAGRANT_HOME/.ssh/id_rsa.pub >> $VAGRANT_HOME/.ssh/authorized_keys
  chmod 0600 $VAGRANT_HOME/.ssh/authorized_keys
  cp $FILE_PATH/ssh-config $VAGRANT_HOME/.ssh/config
}

# TODO change user
function update_permission {
  echo "[*] update permission"
  chown -R vagrant:vagrant /opt/$HADOOP_NAME $VAGRANT_HOME/.ssh /var/hadoop
}

function init_hdfs {
  echo "[*] init hdfs"
  su --login vagrant << EOF
    source /etc/environment
    source /etc/profile.d/hadoop.sh
    hdfs namenode -format
    hadoop version
EOF
}

echo "[-] setup hadoop"
