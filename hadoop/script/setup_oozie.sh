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

EXTJS_NAME="ext-2.2"
OOZIE_VERSION="4.3.0"
OOZIE_NAME="oozie-$OOZIE_VERSION"

##############################

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

  tar -xzf $OOZIE_DIST_PATH -C /opt/
  ln -s /opt/$OOZIE_NAME $OOZIE_BASE_PATH
  mkdir -p $LIB_BASE_PATH
  cp $EXTJS_DIST_PATH $LIB_BASE_PATH
  chown -R $USER_NAME:$USER_NAME /opt/$OOZIE_NAME
}

function main {
  echo "[+] setup oozie"
  setup_dist
  echo "[-] setup oozie"
}

main
