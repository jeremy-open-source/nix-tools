#!/usr/bin/env bash

set -eu -o pipefail

ADDITIONAL_MESSAGE=${1:-""}
if [[ -z "${ADDITIONAL_MESSAGE}" ]] ; then
  ADDITIONAL_MESSAGE=" ${ADDITIONAL_MESSAGE}"
fi

git commit --allow-empty -m "Dummy commit${ADDITIONAL_MESSAGE}"
