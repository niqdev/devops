#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

BOX_NAME="default"
KEY_NAME="vagrant_rsa"
KEY_PATH="data"

##############################

# param #1: <bin>
function verify_requirement {
  local BIN=$1
  command -v $BIN >/dev/null 2>&1 || (echo "[-] error: $BIN not found" && exit 1)
}

# param #1: <name>
# param #2: <path>
function init_key_pair {
  local NAME=$1
  local PATH=$2/$NAME
  if [ ! -e $PATH ]; then
    #mkdir -p $PATH
    #ssh-keygen -t rsa -b 4096 -C $NAME -N "" -f $PATH
    echo "[*] new ssh key pair generated: $PATH"
  else
    echo "[*] ssh key pair found: $PATH"
  fi
}

# param #1: <name>
function start_vagrant {
  local NAME=$1
  local STATUS=$(vagrant status | grep $NAME | awk '{ print toupper($2) }')
  echo -e "[*] name=$NAME | status=$STATUS"

  case $STATUS in
    "POWEROFF")
      vagrant up && vagrant ssh
      ;;
    "RUNNING")
      vagrant ssh
      ;;
    *)
      echo "[-] error: vagrant status unknown"
      ;;
  esac
}

function main {
  verify_requirement vagrant
  verify_requirement ssh-keygen

  init_key_pair $KEY_NAME $KEY_PATH
  #start_vagrant $BOX_NAME
}

main
