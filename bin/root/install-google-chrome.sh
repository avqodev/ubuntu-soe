#!/bin/bash

chrome-install() {
	dpkg-query -W google-chrome-stable \
        && wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --directory-prefix=$SOE_DOWNLOADS \
        && apt-get --assume-yes install $SOE_DOWNLOADS/google-chrome-stable_current_amd64.deb
}

chrome-install
