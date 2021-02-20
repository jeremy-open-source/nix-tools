#!/usr/bin/env bash

set -e


# https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1832988

rmmod btusb
modprobe btusb
