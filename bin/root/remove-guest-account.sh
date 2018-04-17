#!/bin/bash

remove-guest-account() {
    cp -f files/system/50-no-guest.conf /usr/share/lightdm/lightdm.conf.d/
}
remove-guest-account
