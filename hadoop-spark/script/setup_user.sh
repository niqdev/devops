#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

# common
KEY_NAME="hadoop_rsa"
FILE_PATH="/vagrant/file"
DATA_PATH="/vagrant/data"
USER_NAME="hadoop"
HOME_PATH="/home/$USER_NAME"

##############################

echo "[+] setup user"

function create_user {
  local NAME=$1
  echo "[*] create user: $NAME"

  useradd --create-home --shell /bin/bash $NAME
  usermod --append --groups sudo,$NAME $NAME
  id $NAME
  groups $NAME
}

function config_ssh {
  local SSH_PATH="$HOME_PATH/.ssh"
  echo "[*] config ssh"

  mkdir -p $SSH_PATH
  cat $DATA_PATH/$KEY_NAME.pub >> $SSH_PATH/authorized_keys
  chmod 0600 $SSH_PATH/authorized_keys
  cp $FILE_PATH/ssh-config $SSH_PATH/config
  chown -R $USER_NAME:$USER_NAME $SSH_PATH
}

function config_profile {
  sudo sed -i -r "s/alias ll='ls -alF'/alias ll='ls -alh'/" $HOME_PATH/.bashrc
  source $HOME_PATH/.bashrc
}

function main {
  create_user $USER_NAME
  config_ssh
  config_profile
}

main

echo "[-] setup user"
