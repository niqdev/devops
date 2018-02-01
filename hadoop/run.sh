#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

# common
DATA_PATH=".data"
KEY_NAME="hadoop_rsa"
BOX_NAME="master"

##############################

# param #1: <bin>
function verify_requirement {
  local BIN=$1
  echo "[*] verify requirement: $BIN"
  command -v $BIN >/dev/null 2>&1 || (echo "[-] error: $BIN not found" && exit 1)
}

# param #1: <name>
# param #2: <path>
function init_key_pair {
  local NAME=$1
  local BASE_PATH=$2
  local KEY_PATH="$BASE_PATH/$NAME"

  if [ ! -e $KEY_PATH ]; then
    mkdir -p $BASE_PATH
    ssh-keygen -t rsa -b 4096 -C $NAME -N "" -f $KEY_PATH
    echo "[*] new ssh key pair generated: $KEY_PATH"
  else
    echo "[*] ssh key pair found: $KEY_PATH"
  fi
}

# param #1: <name>
function start_vagrant {
  local NAME=$1
  local STATUS=$(vagrant status | grep -m 1 $NAME | awk '{ print toupper($2) }')
  echo -e "[*] start vagrant: name=$NAME | status=$STATUS"

  case $STATUS in
    # not created | poweroff | aborted
    "NOT"|"POWEROFF"|"ABORTED")
      vagrant up && vagrant ssh $NAME
      ;;
    # running
    "RUNNING")
      vagrant ssh $NAME
      ;;
    *)
      echo "[-] error: vagrant status unknown"
      ;;
  esac
}

##############################

function init_folder {
  echo "[*] init folder"
  mkdir -pv \
    ${DATA_PATH}/$BOX_NAME \
    ${DATA_PATH}/node-{1,2,3}
}

function main {
  verify_requirement vagrant
  verify_requirement ssh-keygen

  init_folder
  init_key_pair $KEY_NAME $DATA_PATH
  start_vagrant $BOX_NAME
}

main
