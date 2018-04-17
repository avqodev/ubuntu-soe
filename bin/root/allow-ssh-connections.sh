#!/bin/bash

openssh-install() {
    apt-get install --assume-yes \
        openssh-server \
        fail2ban
}
openssh-install
