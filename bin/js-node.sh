#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$1
export NODE_VERSION=${NODE_VERSION}

docker run \
    -it \
    --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --env HOME=$HOME \
    --volume ${PWD}:/${PWD} \
    --workdir="${PWD}" \
    --network host \
    node:${NODE_VERSION} \
        sh -c "${1}"
