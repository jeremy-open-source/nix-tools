#!/usr/bin/env bash

set -eu -o pipefail

AREA=${1:-"run_tests"}

# TODO: Use ENVs
# TODO: mound /

DOCKER_IMAGE=$(cat .drone.yml | yq --raw-output ".pipeline.${AREA}.image")
COMMANDS=""
for COMMAND in $(cat .drone.yml | yq --raw-output ".pipeline.${AREA}.commands | .[] | @base64"); do
  COMMAND_FULL=$(echo "${COMMAND}" | base64 --decode)
  COMMANDS="${COMMANDS} && ${COMMAND_FULL}"
done
COMMANDS=${COMMANDS:3}

echo "INFO: Running image '${DOCKER_IMAGE}'"
echo "INFO: Running command '${COMMANDS}'"

docker run \
    --rm \
    -it \
    -e PIP_CONFIG_FILE=./pip.conf \
    --volume ${PWD}:/${PWD} \
    --workdir="${PWD}" \
    ${DOCKER_IMAGE} \
    sh -c "${COMMANDS}"
