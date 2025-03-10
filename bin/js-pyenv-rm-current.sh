#!/usr/bin/env bash

set -eu -o pipefail

function wish_to_continue {
  read -p "Are you sure? ('yes' to continue)" -r CONTINUE
  if [[ "${CONTINUE}" != "yes" ]]; then
        echo "Bye"
        exit
  fi
}

PROJECT_NAME=$(basename "$PWD")

echo "Please run:"
echo "pyenv deactivate"
echo "pyenv uninstall ${PROJECT_NAME}"
