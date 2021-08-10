#!/usr/bin/env bash

set -e

# https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

FILE="/tmp/js-ssh-key-gen-echo"
ssh-keygen -t rsa -b 4096 -f "${FILE}" -P ''
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
