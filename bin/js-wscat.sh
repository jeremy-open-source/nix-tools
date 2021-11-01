#!/usr/bin/env bash

JS_NIX_TOOLS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd )"

source ${JS_NIX_TOOLS_DIR}/settings.env

docker run \
    --rm \
    -it \
    --user "$(id -u):$(id -g)" \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume "${PWD}:/${PWD}" \
    -w="${PWD}" \
    "${JS_NIX_TOOLS_DOCKER_IMAGE_PREFIX}-wscat:latest" \
    wscat $@
