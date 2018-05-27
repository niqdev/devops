#!/bin/bash

export ZEPPELLIN_BASE_PATH=/vol/zeppelin
export ZEPPELIN_LOG_DIR=${ZEPPELLIN_BASE_PATH}/log
export ZEPPELIN_NOTEBOOK_DIR=${ZEPPELLIN_BASE_PATH}/notebook

export ZEPPELIN_MEM="-Xms1024m -Xmx1024m"
