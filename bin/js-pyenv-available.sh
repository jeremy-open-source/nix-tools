#!/usr/bin/env bash

set -eu -o pipefail

# WIP!!!!

VERSION_REGEX=${1:-"3\.8\."}
echo "INFO: Looking for version '${VERSION_REGEX}'"

pyenv install --list | grep "${VERSION_REGEX}"
