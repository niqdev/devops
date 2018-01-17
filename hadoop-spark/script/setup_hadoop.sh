#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

echo "[+] setup hadoop"

GUEST_FILES_PATH="/vagrant/file"
VAGRANT_HOME="/home/vagrant"

HADOOP_VERSION="2.7.5"
HADOOP_PATH="hadoop-$HADOOP_VERSION"
HADOOP_DIST="$HADOOP_PATH.tar.gz"

echo "[*] download dist"
wget -q -P /tmp http://www-eu.apache.org/dist/hadoop/common/$HADOOP_PATH/$HADOOP_DIST

echo "[*] setup dist"
tar -xzf /tmp/$HADOOP_DIST -C /opt
rm /tmp/$HADOOP_DIST
ln -s /opt/$HADOOP_PATH /usr/local/hadoop

echo "[*] update env"
echo -e "HADOOP_HOME=/usr/local/hadoop" | tee --append /etc/environment && \
  source /etc/environment
echo -e "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | tee --append /etc/profile.d/hadoop.sh && \
  source /etc/profile.d/hadoop.sh

echo "[*] create data directory"
mkdir -p /var/hadoop/hadoop-datanode /var/hadoop/hadoop-namenode

# http://hadoop.apache.org/docs/r2.7.5/hadoop-project-dist/hadoop-common/core-default.xml
HOST_CONFIG_PATH="$HADOOP_HOME/etc/hadoop"
FILES=( "core-site.xml" "hdfs-site.xml" )
for FILE in "${FILES[@]}"
do
  echo "[*] update config: $FILE"
  mv $HOST_CONFIG_PATH/$FILE $HOST_CONFIG_PATH/$FILE.orig
  cp $GUEST_FILES_PATH/hadoop-$FILE $HOST_CONFIG_PATH/$FILE
done

echo "[*] setup passphraseless ssh"
ssh-keygen -t rsa -P '' -f $VAGRANT_HOME/.ssh/id_rsa
cat $VAGRANT_HOME/.ssh/id_rsa.pub >> $VAGRANT_HOME/.ssh/authorized_keys
chmod 0600 $VAGRANT_HOME/.ssh/authorized_keys
cp $GUEST_FILES_PATH/ssh-config $VAGRANT_HOME/.ssh/config

# TODO change user
echo "[*] fix permissions"
chown -R vagrant:vagrant /opt/$HADOOP_PATH $VAGRANT_HOME/.ssh /var/hadoop

echo "[*] init hdfs"
su --login vagrant << EOF
  source /etc/environment
  source /etc/profile.d/hadoop.sh
  hdfs namenode -format
  hadoop version
EOF

echo "[-] setup hadoop"
