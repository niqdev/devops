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

source $BASE_PATH/setup_java.sh
source $BASE_PATH/setup_hadoop.sh
#sudo $BASE_PATH/setup_spark.sh

#echo "[*] create user"
#useradd --create-home --password hadoop --shell /bin/bash hadoop
#su --login hadoop

#GUEST_FILES_PATH="/vagrant/file"
#VAGRANT_HOME="/home/vagrant"
#ssh-keygen -t rsa -P '' -f $VAGRANT_HOME/.ssh/id_rsa
#cat $VAGRANT_HOME/.ssh/id_rsa.pub >> $VAGRANT_HOME/.ssh/authorized_keys
#chmod 0600 $VAGRANT_HOME/.ssh/authorized_keys
#chown -R vagrant:vagrant $VAGRANT_HOME/.ssh
## TODO switch user
#sudo -u vagrant bash << EOF
#  ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no localhost exit
#EOF
