#!/bin/bash

source $SOE_INSTALL/bin/common/prop.sh

TOOLBOX_VERSION=$(prop 'jetbrains.toolbox.version')
TOOLBOX_INSTALL=$HOME/.jetbrains-toolbox

toolbox-install() {
    if [ ! -d $TOOLBOX_INSTALL ]; then
        wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-$TOOLBOX_VERSION.tar.gz --directory-prefix=$SOE_DOWNLOADS
        ( 
    	    cd $HOME; dtrx $SOE_DOWNLOADS/jetbrains-toolbox-$TOOLBOX_VERSION.tar.gz
    	    mv jetbrains-toolbox-$TOOLBOX_VERSION $TOOLBOX_INSTALL
        )
    fi
}
toolbox-install

nohup $TOOLBOX_INSTALL/jetbrains-toolbox&
