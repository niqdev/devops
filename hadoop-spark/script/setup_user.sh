#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup user"

groupadd hadoop
useradd --create-home --password hadoop --shell /bin/bash hadoop
usermod --append --groups sudo,hadoop username

id hadoop
groups hadoop

echo "[-] setup user"
