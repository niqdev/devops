#!/bin/bash

# unofficial bash strict mode
set -euo pipefail
IFS=$'\n\t'

# run from any directory (no symlink allowed)
CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd -P)
cd ${CURRENT_PATH}

##############################

# common
SCRIPT_PATH="/vagrant/script"
USER_NAME="hadoop"

##############################

su --login $USER_NAME $SCRIPT_PATH/start_hadoop.sh
