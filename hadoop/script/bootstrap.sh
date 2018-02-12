#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

USER_NAME="hadoop"

PARAM_SERVICE_NAME=${1:-"all"}

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
  # check if exists
  if [ -x "$(command -v oozie)" ]; then
    echo "[*] start oozie"
    oozied.sh start
    oozie admin -oozie http://localhost:11000/oozie -status
  fi
}

function start_all {
  start_hadoop
  start_oozie
}

function main {
  echo "[+] boostrap"
  local SERVICE_NAME=$(echo "${PARAM_SERVICE_NAME}" | awk '{print toupper($0)}')

  case $SERVICE_NAME in
    "OOZIE")
      start_oozie
      ;;
    *)
      # TODO all
      start_all
      ;;
  esac
  echo "[-] boostrap"
}

if [ $USER_NAME == "$(whoami)" ]; then
  main
else
  echo "[-] execute as [$USER_NAME] user only"
fi
