#!/usr/bin/env bash

set -eu -o pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

# Make sure we have the first argument
if [[ $# -eq 0 ]] ; then
    echo "ERROR: No arguments supplied"
    exit 1
fi

#---SCRIPT-------------------------------------------------------------------

# Make sure we have the first argument
if [[ $# -eq 0 ]] ; then
    echo "ERROR: No arguments supplied"
    exit 1
fi

# Run the command
COMMAND=$1
docker-compose --file "${DIR}/../docker-compose.yml" --project-directory "${DIR}/.." run \
    --rm \
    --user $(id -u):$(id -g) \
    -e HOME=$HOME \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${HOME}:${HOME} \
    --volume ${PWD}:${PWD} \
    --workdir="${PWD}" \
    chefdk-and-docker \
        bash -c "${COMMAND}"
