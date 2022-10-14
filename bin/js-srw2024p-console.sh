#!/usr/bin/env bash

set -e

picocom \
  --baud=38400 \
  --databits=8 \
  --parity=n \
  --stopbits=1 \
  --flow=n \
  /dev/ttyUSB0
