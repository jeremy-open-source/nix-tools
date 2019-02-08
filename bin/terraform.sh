#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

docker run \
    -it \
    --rm \
    --user $(id -u):$(id -g) \
    --env HOME=$HOME \
    --volume $HOME/.secrets:$HOME/.secrets:ro \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${PWD}:/${PWD} \
    --network host \
    hashicorp/terraform:${TERRAFORM_VERSION} \
    ${COMMAND}
