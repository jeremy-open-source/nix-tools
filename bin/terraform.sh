#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

docker run \
    -it \
    --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --env HOME=$HOME \
    --volume $HOME/.aws:$HOME/.aws:ro \
    --volume ${PWD}:/${PWD} \
    --workdir="${PWD}" \
    --network host \
    hashicorp/terraform:${TERRAFORM_VERSION} \
    ${COMMAND}
