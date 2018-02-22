#!/usr/bin/env bash

export HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
export SPARK_LOG_DIR=/vol/spark/log
# fix warning in spark-shell
export SPARK_LOCAL_IP=$(hostname -i | sed 's/^127.0.0.1 //')
