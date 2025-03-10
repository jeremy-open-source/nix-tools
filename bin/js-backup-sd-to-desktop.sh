#!/usr/bin/env bash

set -eu -o pipefail

INPUT_FILE="/dev/sdb"
OUTPUT_FILE="$HOME/sdb-$(date +%s).gz"

echo "Backing up '${INPUT_FILE}' to '${OUTPUT_FILE}'"
read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        sudo dd if=${INPUT_FILE} | gzip > ${OUTPUT_FILE}
        ;;
    *)
        echo "Aborting! Bye"
        ;;
esac
