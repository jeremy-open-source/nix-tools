#!/usr/bin/env bash

set -e

DOCKER_IMAGE="registry.gitlab.com/mage-sauce/programs/ci-tools:develop"

docker pull ${DOCKER_IMAGE}

docker run \
  --rm \
  -it \
  -v `pwd`:`pwd` \
  -w `pwd` \
  --user="`id -u`" \
  ${DOCKER_IMAGE} \
  bash
