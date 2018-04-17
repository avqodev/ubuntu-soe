#!/bin/bash

source $SOE_INSTALL/bin/common/prop.sh

NVM_VERSION=$(prop 'nvm.version')

nvm-install() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash
}
nvm-install
