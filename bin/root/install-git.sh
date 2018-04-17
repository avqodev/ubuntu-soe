#!/bin/bash

git-install() {
    add-apt-repository --yes ppa:git-core/ppa
    apt-get update
    apt-get --assume-yes install git
}
git-install
