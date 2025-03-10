#!/usr/bin/env bash

set -eu -o pipefail

# https://stackoverflow.com/questions/28991015/python3-project-remove-pycache-folders-and-pyc-files/46822695

find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
