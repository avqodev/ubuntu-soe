#!/bin/bash

docker-install() {
    apt-get --assume-yes install \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    
    if apt-key fingerprint 0EBFCD88 | grep -q "Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88";
    then
        add-apt-repository --yes \
           "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
           $(lsb_release -cs) \
           stable"    
        apt-get update
        apt-get --assume-yes install docker-ce
    fi
}
docker-install
