#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

USER_NAME="hadoop"
FILE_PATH="/vagrant/file"
KEY_PATH="/vagrant/data/vagrant_rsa"

##############################

echo "[+] setup user"

function create_user {
  local NAME=$1
  useradd --create-home --shell /bin/bash $NAME
  usermod --append --groups sudo,$NAME $NAME
  echo "[*] create user: $NAME"
  id $NAME
  groups $NAME
}

function config_ssh {
  local SSH_PATH="/home/$USER_NAME/.ssh"
  echo "[*] config ssh"
  mkdir -p $SSH_PATH
  cat $KEY_PATH.pub >> $SSH_PATH/authorized_keys
  chmod 0600 $SSH_PATH/authorized_keys
  cp $FILE_PATH/ssh-config $SSH_PATH/config
}

function main {
  create_user $USER_NAME
  config_ssh
}

main

echo "[-] setup user"
