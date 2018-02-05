#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] start hadoop"

function start_daemons {
  local HOSTNAME=$(hostname)
  echo "[*] start daemons: $HOSTNAME"
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

start_daemons

echo "[-] start hadoop"
