#!/bin/bash

oranchelo-install() {
    add-apt-repository --yes ppa:oranchelo/oranchelo-icon-theme
    apt-get update
    apt-get --assume-yes install oranchelo-icon-theme
}
oranchelo-install
