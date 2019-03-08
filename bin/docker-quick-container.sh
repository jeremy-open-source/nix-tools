#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

CONTAINER=$1

if [ $# -eq 0 ]; then
  CONTAINER="ubuntu:18.04"
  COMMAND="bash"
elif [ $# -eq 1 ]; then
  CONTAINER=$1
  COMMAND="bash"
elif [ $# -eq 2 ]; then
  CONTAINER=$1
  COMMAND=$2
fi

docker run \
    --rm \
    -it \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${PWD}:/${PWD} \
    --volume "$PWD:/output" \
    --workdir="${PWD}" \
    --network host \
    ${CONTAINER} \
    ${COMMAND}
