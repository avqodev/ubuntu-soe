#!/bin/bash

java-install() {
    add-apt-repository --yes ppa:webupd8team/java
    
    apt-get --assume-yes update
    
    apt-get --assume-yes install oracle-java8-installer
    apt-get --assume-yes install openjdk-8-jdk
    apt-get --assume-yes install default-jdk
    apt-get --assume-yes install oracle-java8-set-default
}
java-install
