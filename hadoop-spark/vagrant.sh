#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

BOX_NAME="default"
KEY_PATH="data/vagrant_rsa"

##############################

function verify_requirements {
  echo "[*] verify requirements"
  command -v vagrant >/dev/null 2>&1 || (echo "[-] error: vagrant not found" && exit 1)
  #command -v vboxmanage >/dev/null 2>&1 || (echo "[-] error: VirtualBox not found" && exit 1)
  command -v ssh-keygen >/dev/null 2>&1 || (echo "[-] error: ssh-keygen not found" && exit 1)
}

# param: <path>
function init_key_pair {
  local PATH=$1
  if [ ! -f $PATH ]; then
    ssh-keygen -q -N "" -f $PATH
    echo "[*] new ssh key pair generated: $PATH"
  else
    echo "[*] ssh key pair found: $PATH"
  fi
}

# param: <name>
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
  verify_requirements
  init_key_pair
  start_vagrant $BOX_NAME
}

main
