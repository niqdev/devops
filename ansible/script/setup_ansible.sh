#!/bin/bash

echo "[+] setup ansible"

sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update

sudo apt-get install -y \
  software-properties-common \
  ansible

sudo sed -i -r "s/#host_key_checking = False/host_key_checking = False/" /etc/ansible/ansible.cfg

echo "[-] setup ansible"
