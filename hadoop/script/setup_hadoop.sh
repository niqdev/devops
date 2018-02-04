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

HADOOP_VERSION="2.7.5"
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

function update_env {
  echo "[*] update env"
  echo -e "HADOOP_HOME=/usr/local/hadoop" | tee --append /etc/environment && \
    source /etc/environment
  echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | tee --append /etc/profile.d/hadoop.sh && \
    source /etc/profile.d/hadoop.sh
}

function setup_config {
  local TMP_DATA_PATH="/var/hadoop"
  local CONFIG_PATH="$HADOOP_HOME/etc/hadoop"
  local FILES=( "core-site.xml" "hdfs-site.xml" "mapred-site.xml" "yarn-site.xml" )

  echo "[*] create data directory"
  mkdir -pv \
    $TMP_DATA_PATH/hadoop-datanode \
    $TMP_DATA_PATH/hadoop-namenode \
    $TMP_DATA_PATH/mr-history/tmp \
    $TMP_DATA_PATH/mr-history/done
  
  ln -s $TMP_DATA_PATH $DATA_PATH
  
  for FILE in "${FILES[@]}"
  do
    echo "[*] update config: $FILE"
    mv $CONFIG_PATH/$FILE $CONFIG_PATH/$FILE.orig
    cp $FILE_PATH/hadoop/config/$FILE $CONFIG_PATH/$FILE
  done

  chown -R $USER_NAME:$USER_NAME \
    $HADOOP_HOME \
    $TMP_DATA_PATH
}

function init_hdfs {
  local HOSTNAME=$(hostname)
  echo "[*] init hdfs: $HOSTNAME"

  case $HOSTNAME in
    "master")
      echo "[+] TODO master"
      ;;
    *)
      echo "[+] TODO all"
      ;;
  esac
}

function main {
  echo "[+] setup hadoop"
  setup_dist
  update_env
  setup_config
  init_hdfs
  echo "[-] setup hadoop"
}

main


