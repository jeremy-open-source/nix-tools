#!/usr/bin/env bash

set -eu -o pipefail

# WIP!!!!

function wish_to_continue {
  read -p "Are you sure? ('yes' to continue)" -r CONTINUE
  if [[ "${CONTINUE}" != "yes" ]]; then
        echo "Bye"
        exit
  fi
}

# HELP / COMMANDS
# * Available versions to install `pyenv install -l`
# * Available versions to install (non external) `pyenv install -l | grep -e "^  [0-9]" | grep -v -e "dev" -e "b"`
# * Install a version `pyenv install 3.8.11`
# * Remove Py environment `pyenv uninstall my-virtual-env-name`

# VERSION="3.6.14"  # Ubuntu 18.04
# VERSION="3.8.11"
VERSION=${1-"3.9.6"}

PROJECT_NAME=$(basename "$PWD")
# Versions = 'pyenv versions'
COMMAND_1="pyenv install \"${VERSION}\" || true"
COMMAND_2="pyenv virtualenv \"${VERSION}\" \"${PROJECT_NAME}\""
COMMAND_3="pyenv activate \"${PROJECT_NAME}\""
COMMAND_4="pip install pip-tools"

echo "INFO: I will run:"
echo "INFO: '${COMMAND_1}'"
echo "INFO: '${COMMAND_2}'"
echo "INFO: '${COMMAND_3}'"
echo "INFO: '${COMMAND_4}'"
wish_to_continue

eval ${COMMAND_1}
eval ${COMMAND_2}
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval ${COMMAND_3}
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval ${COMMAND_4}

echo "Please run the following commands:"
echo "* '${COMMAND_3}'"
# echo "* 'pip install pip-tools'"

# Note: To remove
