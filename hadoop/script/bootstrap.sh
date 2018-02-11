#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

SCRIPT_PATH="/vagrant/script"
USER_NAME="hadoop"

##############################

function start_hadoop {
  local HOSTNAME=$(hostname)
  echo "[*] start hadoop on [$HOSTNAME]"
  hadoop version

  case $HOSTNAME in
    "master")
      hadoop-daemon.sh --script hdfs start namenode
      hadoop-daemon.sh --script hdfs start secondarynamenode
      yarn-daemon.sh start resourcemanager
      yarn-daemon.sh start proxyserver
      mr-jobhistory-daemon.sh start historyserver
      ;;
    *)
      hadoop-daemons.sh --script hdfs start datanode
      yarn-daemons.sh start nodemanager
      ;;
  esac

  jps
}

function start_oozie {
  if [ -x "$(command -v oozie)" ]; then
    echo "[*] start oozie"
    oozied.sh start
  fi
}

function main {
  echo "[+] boostrap"
  start_hadoop
  #start_oozie
  echo "[-] boostrap"
}

sudo -i -u $USER_NAME main