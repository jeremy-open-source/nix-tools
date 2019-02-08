#!/usr/bin/env bash

set -e

# Not fully tested!

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

#
#echo $COMMAND
#echo ""

docker run \
    --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${PWD}:/${PWD} \
    --volume "$PWD:/output" \
    --network host \
    schemaspy/schemaspy:${SCHEMASPY_VERSION} \
    ${COMMAND}
