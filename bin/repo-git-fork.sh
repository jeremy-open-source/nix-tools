#!/usr/bin/env bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ROOT_DIR=$(realpath "${SCRIPT_DIR}/..")
TMP_DIR="${ROOT_DIR}/temp"

TMP_PROJECT_DIR=$(mktemp -d --tmpdir=${TMP_DIR})

read -r -p "Repo source (git@..) " REPO_SOURCE
read -r -p "Repo destination (git@..) " REPO_DEST

git clone --mirror ${REPO_SOURCE} ${TMP_PROJECT_DIR}
cd ${TMP_PROJECT_DIR}
# git remote set-url origin ${REPO_DEST}
git push --mirror ${REPO_DEST}
