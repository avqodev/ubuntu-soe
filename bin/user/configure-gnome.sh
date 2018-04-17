#!/bin/bash

source $SOE_INSTALL/bin/common/prop.sh

set-gnome-theme() {
    gsettings set org.gnome.desktop.interface gtk-theme $GNOME_THEME
    gsettings set org.gnome.desktop.wm.preferences theme $GNOME_THEME
}

set-gnome-icon-theme() {
    gsettings set org.gnome.desktop.interface icon-theme $GNOME_ICON_THEME
}

set-gnome-background() {
    gsettings set org.gnome.desktop.background picture-uri "file:///${GNOME_BACKGROUND_LOCATION}"
}

configure-gnome-launcher() {
    gsettings set com.canonical.Unity.Launcher launcher-position $GNOME_LAUNCHER_POSITION
    gsettings set com.canonical.Unity.Launcher favorites "['application://org.gnome.Nautilus.desktop', 'application://gnome-terminal.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://desktop-icon', 'unity://expo-icon', 'unity://devices']"
}

GNOME_THEME=$(prop 'gnome.theme')
GNOME_ICON_THEME=$(prop 'gnome.icon.theme')
GNOME_BACKGROUND_LOCATION=$(prop 'gnome.background')
GNOME_LAUNCHER_POSITION=$(prop 'gnome.launcher.position')

set-gnome-theme
set-gnome-icon-theme
set-gnome-background
configure-gnome-launcher
