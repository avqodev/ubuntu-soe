#!/bin/bash

disable-sleep() {
    systemctl disable systemd-hybrid-sleep
}
disable-sleep
