#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup java"

apt-get update && apt-get upgrade -y
add-apt-repository ppa:openjdk-r/ppa -y

apt-get update && apt-get install -y \
  openjdk-8-jdk && \
  apt-get clean

echo "[-] setup java"
