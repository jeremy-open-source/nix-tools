#!/usr/bin/env bash

set -eu -o pipefail


# https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1832988

rmmod btusb
modprobe btusb
