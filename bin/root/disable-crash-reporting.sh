#!/bin/bash

disable-crash-reporting() {
    cp -f $SOE_INSTALL/files/system/etc/default/apport /etc/default/apport
}
disable-crash-reporting
