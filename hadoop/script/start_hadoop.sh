#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] start hadoop"

function start_daemons {
  start-dfs.sh
  start-yarn.sh
  mr-jobhistory-daemon.sh start historyserver
  jps
}

start_daemons

echo "[-] start hadoop"
