#!/usr/bin/env bash

set -e

# TODO: Would be nice to be able to get these from an API in the future
declare -a TAGS=(
  "1.0.0"
  "1.1.0.1600258451"
  "1.2.0.1600287813"
  "develop"
  "latest"
  "master"
  "stable"
)

REPO_SOURCE=${1:-""}
if [[ -z "${REPO_SOURCE}" ]] ; then
  read -r -p "Source (e.g. registry.gitlab.com/.../project) " REPO_SOURCE
fi

REPO_DEST=${2:-""}
if [[ -z "${REPO_DEST}" ]] ; then
  read -r -p "Destination (e.g. registry.gitlab.com/.../project) " REPO_DEST
fi

for TAG in ${TAGS[@]}; do
  SOURCE_TAGGED="${REPO_SOURCE}:${TAG}"
  DEST_TAGGED="${REPO_DEST}:${TAG}"
  docker pull ${SOURCE_TAGGED}
  docker tag ${SOURCE_TAGGED} ${DEST_TAGGED}
  docker push ${DEST_TAGGED}
done
