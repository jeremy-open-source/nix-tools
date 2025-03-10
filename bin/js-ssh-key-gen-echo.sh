#!/usr/bin/env bash

set -eu -o pipefail

# https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

FILE="/tmp/js-ssh-key-gen-echo"
ssh-keygen -t ed25519 -f "${FILE}" -P '' -C ""
# ssh-keygen -t rsa -b 4096 -f "${FILE}" -P '' -C ""
echo ""

echo "INFO: id_rsa"
cat "${FILE}"
echo ""

echo "INFO: id_rsa.pub"
cat "${FILE}.pub"
echo ""

rm "${FILE}"
rm "${FILE}.pub"

echo "INFO: Done!"
echo ""
