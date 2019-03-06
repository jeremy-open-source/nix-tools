#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

# Note: Set "AWS PROFILE" in ~/.bash_rc e.g.
# export AWS_PROFILE=something

docker run \
    -it \
    --rm \
    --user $(id -u):$(id -g) \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --env HOME=$HOME \
    --env AWS_PROFILE=${AWS_PROFILE} \
    --volume $HOME/.aws:$HOME/.aws:ro \
    --volume ${PWD}:/${PWD} \
    --workdir="${PWD}" \
    --network host \
    hashicorp/terraform:${TERRAFORM_VERSION} \
    ${COMMAND}
