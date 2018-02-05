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

function setup_config {
  local TMP_DATA_PATH="/var/hadoop"
  local HADOOP_BASE_PATH="/usr/local/hadoop"
  local CONFIG_PATH="$HADOOP_BASE_PATH/etc/hadoop"
  local FILES=( "core-site.xml" "hdfs-site.xml" "mapred-site.xml" "yarn-site.xml" "masters" "slaves" )

  echo "[*] create data directory"
  mkdir -pv \
    $TMP_DATA_PATH/namenode \
    $TMP_DATA_PATH/secondary \
    $TMP_DATA_PATH/datanode \
    $TMP_DATA_PATH/mr-history/tmp \
    $TMP_DATA_PATH/mr-history/done \
    $TMP_DATA_PATH/log \
    $TMP_DATA_PATH/log/app
  
  for FILE in "${FILES[@]}"
  do
    echo "[*] update config: $FILE"
    # rename only if exists
    [ -e $CONFIG_PATH/$FILE ] && mv $CONFIG_PATH/$FILE $CONFIG_PATH/$FILE.orig
    cp $FILE_PATH/hadoop/config/$FILE $CONFIG_PATH/$FILE
  done

  # important final slash to be recursive
  chown -R $USER_NAME:$USER_NAME \
    $HADOOP_BASE_PATH/ \
    $TMP_DATA_PATH/
}

function update_env {
  echo "[*] update env"
  # find files containing word
  # grep -rnw /usr/local/hadoop -e 'HADOOP_LOG_DIR'

  echo -e "HADOOP_HOME=/usr/local/hadoop\nHADOOP_LOG_DIR=/var/hadoop/log" | tee --append /etc/environment && \
    source /etc/environment
  echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | tee --append /etc/profile.d/hadoop.sh && \
    source /etc/profile.d/hadoop.sh
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
  update_env
  init_hdfs
  echo "[-] setup hadoop"
}

main


