#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup spark"

wget -P /tmp http://www-eu.apache.org/dist/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz

tar -xvf /tmp/spark-2.2.1-bin-hadoop2.7.tgz -C /opt

# TODO verify signatures and checksums
# scala version ?

echo "[-] setup spark"
