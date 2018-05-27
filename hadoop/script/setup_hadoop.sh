#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

FILE_PATH="/vagrant/file"
DATA_PATH="/vagrant/.data"
USER_NAME="hadoop"

HADOOP_VERSION="2.7.6"
HADOOP_NAME="hadoop-$HADOOP_VERSION"

##############################

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
  chown -R $USER_NAME:$USER_NAME /opt/$HADOOP_NAME
}

function setup_config {
  local DATA_PATH_GUEST="/vol/hadoop"
  local HADOOP_BASE_PATH="/usr/local/hadoop"
  local CONFIG_PATH="$HADOOP_BASE_PATH/etc/hadoop"
  local FILES=( "core-site.xml" "hdfs-site.xml" "mapred-site.xml" "yarn-site.xml" "fair-scheduler.xml" "masters" "slaves" )

  echo "[*] create directories"
  mkdir -pv \
    $DATA_PATH_GUEST/{namenode,secondary,datanode} \
    $DATA_PATH_GUEST/log/{hadoop,yarn,mapred}
  
  for FILE in "${FILES[@]}"
  do
    echo "[*] update config: $FILE"
    # backup only if exists
    [ -e $CONFIG_PATH/$FILE ] && mv $CONFIG_PATH/$FILE $CONFIG_PATH/$FILE.orig
    cp $FILE_PATH/hadoop/config/$FILE $CONFIG_PATH/$FILE
  done

  echo "[*] update permissions"
  # important final slash to be recursive
  chown -R $USER_NAME:$USER_NAME \
    $HADOOP_BASE_PATH/ \
    $DATA_PATH_GUEST/
  
  echo "[*] update env"
  cp $FILE_PATH/hadoop/profile-hadoop.sh /etc/profile.d/profile-hadoop.sh && \
    source /etc/profile.d/profile-hadoop.sh
}

function init_hdfs {
  local HOSTNAME=$(hostname)
  echo "[*] init hdfs: $HOSTNAME"
  hadoop version

  case $HOSTNAME in
    "master")
      sudo -i -u $USER_NAME hdfs namenode -format
      ;;
    *)
      # nothing to do
      ;;
  esac
}

function main {
  echo "[+] setup hadoop"
  setup_dist
  setup_config
  init_hdfs
  echo "[-] setup hadoop"
}

main
