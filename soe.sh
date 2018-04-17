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

SOE_USER=$USER
SOE_INSTALL_DIR=/home/$SOE_USER/.soe
SOE_VERSION="1.0.0"

SOE_URL="https://github.com/avqodev/ubuntu-soe/archive/master.zip"
SOE_STAGE_DIR="${SOE_INSTALL_DIR}/stage"
SOE_ZIP="${SOE_STAGE_DIR}/soe-${SOE_VERSION}.zip"

download() {
    mkdir --parents $SOE_INSTALL_DIR
    mkdir --parents $SOE_STAGE_DIR
    mkdir --parents $SOE_INSTALL_DIR/logs
    mkdir --parents $SOE_INSTALL_DIR/temp
    curl --location --progress-bar "${SOE_URL}" > "$SOE_ZIP"
    unzip -qo "$SOE_ZIP" -d "$SOE_INSTALL_DIR"
    mv "$SOE_STAGE_DIR"/* "$SOE_INSTALL_DIR"
}

set_version() {
    mkdir --parents $SOE_INSTALL/var
    echo "$SOE_VERSION" > "${SOE_INSTALL_DIR}/var/version"
}

download
set_version
