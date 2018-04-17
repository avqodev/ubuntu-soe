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
SOE_INSTALL=/home/$SOE_USER/.soe

SOE_URL="https://github.com/avqodev/ubuntu-soe/archive/master.zip"

OPTS=$(getopt -n 'parse-options' -o s:u:iz --long script:,user:,development-user,no-download -- "$@")

eval set -- "$OPTS"

while true; do
    case "$1" in
        -i | --development-user ) SOE_USER=development; NEW_USER=1; shift ;;
        -s | --script ) TARGET_SCRIPT="$2"; shift 2 ;;
        -u | --user ) SOE_USER="$2"; NEW_USER=1; shift 2 ;;
        -z | --no-download ) NO_DOWNLOAD=1; SOE_INSTALL=.; shift ;;
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
    if ! id $SOE_USER >/dev/null 2>&1; then
        adduser $SOE_USER
        usermod -aG sudo $SOE_USER
    fi
fi

if [[ ! $NO_DOWNLOAD && ! ]]; then
    download() {
        sudo -H -u $SOE_USER mkdir --parents $SOE_INSTALL
        sudo -H -u $SOE_USER mkdir --parents $SOE_INSTALL/logs
        sudo -H -u $SOE_USER mkdir --parents $SOE_INSTALL/temp
        wget $SOE_URL --directory-prefix=/tmp
        unzip /tmp/master.zip -d $SOE_INSTALL
        chown -R $SOE_USER:$SOE_USER $SOE_INSTALL
    }
    download
fi

SOE_DOWNLOADS=$SOE_INSTALL/temp

execute-root-scripts() {
    run-parts \
        --test --regex "^${1:-.*\.sh}$" --exit-on-error --new-session --verbose $SOE_INSTALL/bin/root/enabled --
}

execute-user-scripts() {	
    sudo -H -u $SOE_USER run-parts --test --regex "^${1:-.*\.sh}$" --exit-on-error --new-session --verbose $SOE_INSTALL/bin/user/enabled --
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
