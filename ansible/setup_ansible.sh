#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup ansible"

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update

sudo apt-get install -y \
  software-properties-common \
  ansible

sudo sed -i -r "s/#host_key_checking = False/host_key_checking = False/" /etc/ansible/ansible.cfg

echo "[-] setup ansible"
