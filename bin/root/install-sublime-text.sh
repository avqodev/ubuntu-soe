#!/bin/bash

sublime-install() {
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
    apt-get update
    apt-get --assume-yes install \
                            sublime-text \
                            apt-transport-https
}
sublime-install
