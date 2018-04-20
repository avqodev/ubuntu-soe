#!/bin/bash

source $SOE_INSTALL/bin/common/prop.sh

sdkman-java-install() {
    sdk install java $(prop 'java.9.version')-openjdk
    sdk install java $(prop 'java.10.version')-openjdk
}

sdkman-maven-install() {
    sdk install maven
}

sdkman-groovy-install() {
    sdk install groovy
}

sdkman-visualvm-install() {
    sdk install visualvm
}

sdkman-java-install
sdkman-maven-install
sdkman-groovy-install
sdkman-visualvm-install
