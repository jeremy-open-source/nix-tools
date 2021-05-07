#!/usr/bin/env bash

set -e

function wish_to_continue {
  read -p "Are you sure? ('yes' to continue)" -r CONTINUE
  if [[ "${CONTINUE}" != "yes" ]]; then
        echo "Bye"
        exit
  fi
}

PROJECT_NAME=$(basename "$PWD")
# Versions = 'pyenv versions'
COMMAND="pyenv virtualenv 3.7.6 ${PROJECT_NAME}"

echo "INFO: Command '${COMMAND}'"
wish_to_continue

eval $COMMAND
echo "Please run the following command:"
echo "pyenv activate ${PROJECT_NAME}"
echo "Then run 'pip install pip-tools'"

# Note: To remove `pyenv uninstall my-virtual-env`
