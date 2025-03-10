#!/usr/bin/env bash

set -eu -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@
export YARN_NODE_VERSION=${YARN_NODE_VERSION}

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
    node:${YARN_NODE_VERSION} \
        yarn \
            ${COMMAND}
