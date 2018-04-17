#!/bin/bash

extras-install() {
    apt-get --assume-yes install \
            ubuntu-restricted-extras \
            build-essential \
            libssl-dev \
            gzip \
            curl \
            ack-grep \
            tree \
            squid \
            tmux \
            tmuxinator \
            vim \
            emacs \
            ksh \
            wireshark \
            virtualbox \
            aptitude \
            highlight \
            dtrx \
            lm-sensors \
            apt-show-versions \
            flashplugin-installer \
            unity-tweak-tool \
            gnome-tweak-tool \
            grc \
            openvpn \
            geary      
}
extras-install
