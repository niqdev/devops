#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[*] whoami: $(whoami)"
echo "[*] pwd: $(pwd)"

BASE_PATH="/vagrant/script"

sudo $BASE_PATH/setup_java.sh
sudo $BASE_PATH/setup_hadoop.sh
sudo $BASE_PATH/setup_spark.sh

#echo "[*] create user"
#useradd --create-home --password hadoop --shell /bin/bash hadoop
#su --login hadoop
