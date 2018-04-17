#!/bin/bash
#
#   Copyright 2018 AVQO Ltd
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

set -eo pipefail

SOE_USER=$SUDO_USER
_SCRIPT="$(readlink -f ${BASH_SOURCE[0]})"
SOE_INSTALL="$(dirname $_SCRIPT)"
SOE_VERSION="1.0.0"

SOE_URL="https://github.com/avqodev/ubuntu-soe/archive/master.zip"
SOE_STAGE_DIR="${SOE_INSTALL_DIR}/stage"
SOE_ZIP="${SOE_STAGE_DIR}/soe-${SOE_VERSION}.zip"

OPTS=$(getopt -n 'parse-options' -o s:u:iz --long script:,user:,development-user,no-download -- "$@")

eval set -- "$OPTS"

while true; do
    case "$1" in
        -f | --force-download ) FORCE_DOWNLOAD=1; shift ;;
        -i | --development-user ) SOE_USER=development; NEW_USER=1; shift ;;
        -s | --script ) TARGET_SCRIPT="$2"; shift 2 ;;
        -u | --user ) SOE_USER="$2"; NEW_USER=1; shift 2 ;;
        -- ) shift; break ;;
        * ) break ;;
    esac
done

if [[ $HELP ]]; then
    _help() {
        echo "usage: 'run.sh [OPTIONS]'"
    }
    _help; exit
fi

if [[ $NEW_USER ]]; then
    id -u $SOE_USER &>/dev/null || adduser $SOE_USER
fi
usermod -aG sudo $SOE_USER

if [[ $FORCE_DOWNLOAD ]]; then
    download() {
        mkdir --parents $SOE_INSTALL_DIR
        mkdir --parents $SOE_STAGE_DIR
        mkdir --parents $SOE_INSTALL_DIR/logs
        mkdir --parents $SOE_INSTALL_DIR/temp
        curl --location --progress-bar "${SOE_URL}" > "$SOE_ZIP"
        unzip -qo "$SOE_ZIP" -d "$SOE_STAGE_DIR"
        rm "$SOE_ZIP"
        mv "$SOE_STAGE_DIR"/ubuntu-soe-master/* "$SOE_INSTALL_DIR"
    }
    download
fi

SOE_DOWNLOADS=$SOE_INSTALL/temp

execute-root-scripts() {
    run-parts \
        --regex "^${1:-.*\.sh}$" --exit-on-error --new-session --verbose $SOE_INSTALL/bin/root/enabled --
}

execute-user-scripts() {	
    sudo -H -u $SOE_USER run-parts --regex "^${1:-.*\.sh}$" --exit-on-error --new-session --verbose $SOE_INSTALL/bin/user/enabled --
}

if [[ $TARGET_SCRIPT ]]; then
    execute-single() {
        if [ -f $SOE_INSTALL/bin/root/${1} ]; then
            execute-root-scripts "${1}"
        else
    	    if [ -f $SOE_INSTALL/bin/user/${1} ]; then
    	        execute-user-scripts "${1}"
    	    fi
        fi 
    }
    execute-single $TARGET_SCRIPT; exit
fi

apt-get update

execute-root-scripts
execute-user-scripts

cleanup() {
	if [ -d $SOE_DOWNLOADS ]; then
	    rm -r $SOE_DOWNLOADS
    fi
}
cleanup
