#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

COMMAND=$@

docker-compose \
    --file "${DIR}/../docker-compose.yml" \
    --project-name ${PROJECT_NAME} \
    run \
        --rm \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume ${PWD}:${PWD} \
        --workdir="${PWD}" \
        mermaidjs \
        /node_modules/.bin/mmdc \
            -p /puppeteer-config.json \
            mermaidjs \
            ${COMMAND}
