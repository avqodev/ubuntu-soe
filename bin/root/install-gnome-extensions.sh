#!/bin/bash

rm -rf $HOME/.local/share/gnome-shell/extensions/*

apt-get install \
        gnome-shell \
        chrome-gnome-shell \
        gnome-tweak-tool \
        gnome-shell-pomodoro

gnome-shell --replace &
