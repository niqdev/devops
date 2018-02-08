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
OOZIE_VERSION="4.3.0"
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
  local LIB_BASE_PATH="$OOZIE_BASE_PATH/libext"
  echo "[*] setup dist"

  if [ ! -e $OOZIE_DIST_PATH ]; then
    download_oozie_dist
  fi
  if [ ! -e $EXTJS_DIST_PATH ]; then
    download_extjs_dist
  fi

  # TODO
  echo "[*] build sources"
  tar -xzf $OOZIE_DIST_PATH -C /tmp
  /tmp/$OOZIE_NAME/bin/mkdistro.sh -DskipTests -Puber -Dhadoop.version=$HADOOP_VERSION
  tar -xzf /tmp/oozie-4.3.0/distro/target/oozie-4.3.0-distro.tar.gz -C /opt
  cd /opt/oozie-4.3.0
  cp /vagrant/.data/ext-2.2.zip libext/
  bin/oozie-setup.sh prepare-war

  #mkdir -p $LIB_BASE_PATH
  #cp $EXTJS_DIST_PATH $LIB_BASE_PATH

  #ln -s /opt/$OOZIE_NAME $OOZIE_BASE_PATH
  #chown -R $USER_NAME:$USER_NAME /opt/$OOZIE_NAME
}

function main {
  echo "[+] setup oozie"
  setup_maven
  setup_dist
  echo "[-] setup oozie"
}

main
