#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup java"

LOG_PATH="/tmp/apt-java.log"

apt-get -qq update #&& apt-get -qq upgrade -y
add-apt-repository ppa:openjdk-r/ppa -y &> $LOG_PATH

apt-get -qq update && apt-get install -y \
  openjdk-8-jdk \
  &> $LOG_PATH && \
  apt-get clean

java -version

# https://askubuntu.com/questions/866161/setting-path-variable-in-etc-environment-vs-profile
# /usr/lib/jvm/java-8-openjdk-amd64
echo "JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")" | sudo tee --append /etc/environment && \
  source /etc/environment

echo "[-] setup java"
