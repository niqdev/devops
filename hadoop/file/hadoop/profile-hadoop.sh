#!/bin/sh

export HADOOP_HOME=/usr/local/hadoop
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:${PATH}

export HADOOP_LOG_PATH=/var/hadoop/log
export HADOOP_LOG_DIR=${HADOOP_LOG_PATH}/hadoop
export YARN_LOG_DIR=${HADOOP_LOG_PATH}/yarn
export HADOOP_MAPRED_LOG_DIR=${HADOOP_LOG_PATH}/mapred
