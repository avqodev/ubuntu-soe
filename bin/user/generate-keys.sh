#!/bin/bash

ALGO=rsa
KEY_SIZE=4096

generate-keys() {
	ssh-keygen -t $ALGO -b $KEY_SIZE
}

if [ ! -f $HOME/.ssh/id_rsa ]; then
    generate-keys
    eval $(ssh-agent -s)
    ssh-add $HOME/.ssh/id_rsa
fi
