#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

# common
FILE_PATH="/vagrant/file"
DATA_PATH="/vagrant/data"
USER_NAME="hadoop"
HOME_PATH="/home/$USER_NAME"

HADOOP_VERSION="2.7.5"
HADOOP_NAME="hadoop-$HADOOP_VERSION"

##############################

echo "[+] setup hadoop"

function download_dist {
  local HADOOP_MIRROR_DOWNLOAD="http://www-eu.apache.org/dist/hadoop/common/$HADOOP_NAME/$HADOOP_NAME.tar.gz"
  echo "[*] download dist"
  wget -q -P $DATA_PATH $HADOOP_MIRROR_DOWNLOAD
}

function setup_dist {
  local HADOOP_DIST_PATH="$DATA_PATH/$HADOOP_NAME*"
  echo "[*] setup dist"

  if [ ! -e $HADOOP_DIST_PATH ]; then
    download_dist
  fi

  tar -xzf $HADOOP_DIST_PATH -C /opt
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
  local SSH_PATH="$HOME_PATH/.ssh"
  echo "[*] setup ssh"

  ssh-keygen -t rsa -P '' -f $SSH_PATH/id_rsa
  cat $SSH_PATH/id_rsa.pub >> $SSH_PATH/authorized_keys
  chmod 0600 $SSH_PATH/authorized_keys
  cp $FILE_PATH/ssh/config $SSH_PATH/config
  chown -R $USER_NAME:$USER_NAME $SSH_PATH
}

function update_permission {
  echo "[*] update permission"
  chown -R $USER_NAME:$USER_NAME /opt/$HADOOP_NAME /var/hadoop
}

function init_hdfs {
  echo "[*] init hdfs"
  su --login $USER_NAME << EOF
    source /etc/environment
    source /etc/profile.d/hadoop.sh
    hdfs namenode -format
    hadoop version
EOF
}

function main {
  setup_dist
  update_env
  setup_config
  setup_ssh
  update_permission
  init_hdfs
}

main

echo "[-] setup hadoop"
