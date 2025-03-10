#!/usr/bin/env bash

set -eu -o pipefail

systemctl --user stop wireplumber
sleep 1
systemctl --user start wireplumber
