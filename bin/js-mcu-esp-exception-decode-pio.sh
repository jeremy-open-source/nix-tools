#!/usr/bin/env bash

set -eu -o pipefail

# DOCKER_IMAGE="esp-stack-trace-decoder-docker_app:latest"
DOCKER_IMAGE="registry.gitlab.com/mage-sauce/dockerization/esp-stack-trace-decoder-docker:latest"

PIO_PROJECT=${1:-${PIO_PROJECT:-""}}
EXCEPTION_FILE=${2:-${EXCEPTION_FILE:-"dump.txt"}}

docker run \
  --rm \
  -it \
  --user $(id -u):$(id -g) \
  -e HOME=$HOME \
  --volume /etc/passwd:/etc/passwd:ro \
  --volume /etc/group:/etc/group:ro \
  --volume ${HOME}:${HOME} \
  --volume ${PWD}:${PWD} \
  --workdir="${PWD}" \
  ${DOCKER_IMAGE} \
  bash -c "pio-esp-exception-decode.sh \"${PIO_PROJECT}\" \"${EXCEPTION_FILE}\""


