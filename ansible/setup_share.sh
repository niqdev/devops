#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup share"

SHARE_PATH="$CURRENT_PATH/.share"
SSH_PATH="$SHARE_PATH/ssh"

echo "share path: $SHARE_PATH"

rm -fr ${SHARE_PATH}
mkdir -p ${SHARE_PATH}/node-{1,2,3} ${SSH_PATH}

ssh-keygen -t rsa -b 4096 -C "ansible" -N "" -f "$SSH_PATH/ansible_rsa"

echo "[-] setup share"
