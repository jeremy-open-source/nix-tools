#!/usr/bin/env bash

set -eu -o pipefail

picocom \
  --baud=115200 \
  --databits=8 \
  --parity=n \
  --stopbits=1 \
  --flow=n \
  /dev/ttyUSB0
