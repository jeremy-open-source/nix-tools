#!/usr/bin/env bash

set -e

# WIP!!!!

function wish_to_continue {
  read -p "Are you sure? ('yes' to continue)" -r CONTINUE
  if [[ "${CONTINUE}" != "yes" ]]; then
        echo "Bye"
        exit
  fi
}

VERSION="3.8.11"

PROJECT_NAME=$(basename "$PWD")
# Versions = 'pyenv versions'
COMMAND="pyenv virtualenv ${VERSION} ${PROJECT_NAME}"

echo "INFO: Command '${COMMAND}'"
wish_to_continue

eval $COMMAND
echo "Please run the following command if it fails!:"
echo "* 'pyenv install ${VERSION}'"
echo "Please run the following commands:"
echo "* 'pyenv activate ${PROJECT_NAME}'"
echo "* 'pip install pip-tools'"

# Note: To remove `pyenv uninstall my-virtual-env`
