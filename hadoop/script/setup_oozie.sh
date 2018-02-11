#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

DATA_PATH="/vagrant/.data"
USER_NAME="hadoop"

HADOOP_VERSION="2.7.5"
EXTJS_NAME="ext-2.2"
OOZIE_VERSION="5.0.0-beta1"
OOZIE_NAME="oozie-$OOZIE_VERSION"

##############################

function setup_maven {
  local LOG_PATH="/tmp/apt-maven.log"
  echo "[*] setup maven"

  apt-get -qq update && apt-get install -y \
    maven \
    &> $LOG_PATH && \
    apt-get clean
  
  mvn -version

  # environment variables
  #export M2_HOME=/usr/share/maven
  #export PATH=${M2_HOME}/bin:${PATH}

  # configuration path
  #/etc/maven
}

function download_oozie_dist {
  local OOZIE_MIRROR_DOWNLOAD="http://www-eu.apache.org/dist/oozie/$OOZIE_VERSION/$OOZIE_NAME.tar.gz"
  echo "[*] download oozie dist"
  wget -q -P $DATA_PATH $OOZIE_MIRROR_DOWNLOAD
}

function download_extjs_dist {
  local EXTJS_MIRROR_DOWNLOAD="http://archive.cloudera.com/gplextras/misc/$EXTJS_NAME.zip"
  echo "[*] download extjs dist"
  wget -q -P $DATA_PATH $EXTJS_MIRROR_DOWNLOAD
}

function setup_dist {
  local OOZIE_DIST_PATH="$DATA_PATH/$OOZIE_NAME*"
  local EXTJS_DIST_PATH="$DATA_PATH/$EXTJS_NAME*"
  local OOZIE_BASE_PATH="/usr/local/oozie"
  local CONFIG_PATH="$OOZIE_BASE_PATH/conf"
  local FILES=( "oozie-env.sh" )
  echo "[*] setup dist"

  if [ ! -e $OOZIE_DIST_PATH ]; then
    download_oozie_dist
  fi
  if [ ! -e $EXTJS_DIST_PATH ]; then
    download_extjs_dist
  fi

  echo "[*] build sources"
  tar -xzf $OOZIE_DIST_PATH -C /tmp
  /tmp/$OOZIE_NAME/bin/mkdistro.sh \
    -DskipTests \
    -Puber \
    -Dhadoop.version=$HADOOP_VERSION
  tar -xzf /tmp/$OOZIE_NAME/distro/target/$OOZIE_NAME-distro.tar.gz -C /opt
  ln -s /opt/$OOZIE_NAME $OOZIE_BASE_PATH

  mkdir -p $OOZIE_BASE_PATH/libext
  cp $EXTJS_DIST_PATH $OOZIE_BASE_PATH/libext

  echo "[*] update permissions"
  chown -R $USER_NAME:$USER_NAME "$OOZIE_BASE_PATH/"

  echo "[*] init oozie"
  su --login $USER_NAME -c "$OOZIE_BASE_PATH/bin/oozie-setup.sh sharelib create -fs hdfs://namenode:9000"
  su --login $USER_NAME -c "$OOZIE_BASE_PATH/bin/ooziedb.sh create -sqlfile oozie.sql -run"

  echo "[*] start oozie"
  # TODO su --login hadoop ??? or move in bootstrap? check if exists first
  #su --login $USER_NAME $OOZIE_BASE_PATH/bin/oozied.sh start

  # TODO change path
  # logs/oozie.log
  # TODO verify is NORMAL
  # bin/oozie admin -oozie http://localhost:11000/oozie -status
  # TODO ui + hosts
  # http://172.16.0.10:11000/

  # https://github.com/martinprobson/vagrant-hadoop-hive-spark
  # http://www.thecloudavenue.com/2013/10/installation-and-configuration-of.html
  # https://oozie.apache.org/docs/5.0.0-beta1/DG_QuickStart.html

  # tar -xzf /usr/local/oozie/oozie-examples.tar.gz
  # sudo cp -R /usr/local/oozie/examples/ /vagrant/.data/
  # hadoop fs -put /usr/local/oozie/examples /examples
  # hadoop fs -rm -R /examples
  # /usr/local/oozie$ bin/oozie job -oozie http://localhost:11000/oozie -config examples/apps/map-reduce/job.properties -run
  # Error: E0501 : E0501: Could not perform authorization operation, Call From master/127.0.0.1 to localhost:8020 failed on connection exception: java.net.ConnectException: Connection refused; For more details see:  http://wiki.apache.org/hadoop/ConnectionRefused
}

# https://www.edureka.co/blog/apache-oozie-tutorial/

function main {
  echo "[+] setup oozie"
  setup_maven
  setup_dist
  echo "[-] setup oozie"
}

main
