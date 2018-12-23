#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

docker run \
    --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${PWD}:/${PWD} \
    -w="${PWD}" \
    ${PHPUNIT_IMAGE}:${PHPUNIT_VERSION} \
    ${COMMAND}
