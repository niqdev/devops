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
  echo "[*] init hdfs: $HOSTNAME"
  hadoop version

  case $HOSTNAME in
    "master")
      start-dfs.sh
      start-yarn.sh
      mr-jobhistory-daemon.sh start historyserver
      jps
      ;;
    *)
      jps
      ;;
  esac
}

start_daemons

echo "[-] start hadoop"
