#!/bin/bash

prop() {
    grep -w "${1}" $SOE_INSTALL/env.properties | cut -d'=' -f2
}
