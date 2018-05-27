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

ZEPPELIN_VERSION="0.7.3"
ZEPPELIN_NAME="zeppelin-$ZEPPELIN_VERSION-bin-all"

##############################

function download_dist {
  local ZEPPELIN_MIRROR_DOWNLOAD="http://www-eu.apache.org/dist/zeppelin/zeppelin-$ZEPPELIN_VERSION/$ZEPPELIN_NAME.tgz"
  echo "[*] download dist"
  wget -q -P $DATA_PATH $ZEPPELIN_MIRROR_DOWNLOAD
}

function setup_dist {
  local ZEPPELIN_DIST_PATH="$DATA_PATH/$ZEPPELIN_NAME*"
  echo "[*] setup dist"

  if [ ! -e $ZEPPELIN_DIST_PATH ]; then
    download_dist
  fi

  tar -xf $ZEPPELIN_DIST_PATH -C /opt
  ln -s /opt/$ZEPPELIN_NAME /usr/local/zeppelin
  chown -R $USER_NAME:$USER_NAME /opt/$ZEPPELIN_NAME
}

function setup_config {
  local DATA_PATH_GUEST="/vol/zeppelin"
  local ZEPPELIN_BASE_PATH="/usr/local/zeppelin"
  local CONFIG_PATH="$ZEPPELIN_BASE_PATH/conf"
  local FILES=( "zeppelin-env.sh" )

  echo "[*] create directories"
  mkdir -pv \
    $DATA_PATH_GUEST/{log,notebook}
  
  for FILE in "${FILES[@]}"
  do
    echo "[*] update config: $FILE"
    # backup only if exists
    [ -e $CONFIG_PATH/$FILE ] && mv $CONFIG_PATH/$FILE $CONFIG_PATH/$FILE.orig
    cp $FILE_PATH/zeppelin/config/$FILE $CONFIG_PATH/$FILE
  done

  echo "[*] update permissions"
  chown -R $USER_NAME:$USER_NAME \
    $ZEPPELIN_BASE_PATH/
  
  echo "[*] update env"
  cp $FILE_PATH/zeppelin/profile-zeppelin.sh /etc/profile.d/profile-zeppelin.sh && \
    source /etc/profile.d/profile-zeppelin.sh
}

function main {
  echo "[+] setup zeppelin"
  setup_dist
  setup_config
  echo "[-] setup zeppelin"
}

main
