#!/usr/bin/env bash

set -eu -o pipefail

# https://stackoverflow.com/questions/56870755/how-do-i-remove-all-packages-installed-by-pip/56870823
pip uninstall -y -r <(pip freeze)
