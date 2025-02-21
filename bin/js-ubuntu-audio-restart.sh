#!/usr/bin/env bash

set -e

systemctl --user stop wireplumber
sleep 1
systemctl --user start wireplumber
