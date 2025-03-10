#!/usr/bin/env bash

set -eu -o pipefail

# Notes:
# * This script is meant to be loaded from the root of a project
# * There is security concerns with loading ssh keys into a container!!! Use at your own risk!
# * Use this script at your own risk.
# * Docker for Mac probably will not work with this (sorry I am a Linux user)
# * If you are calling this from Jenkins which is running in a Docker container, good luck - but it is possible!
# * * Hint: The volume mounts for Jenkins in Docker are relative to the host! (A symlink will fix this)
# * * Hint: Add a user to the host that's got a fixed ID and also has the same UID and GID as Jenkins in the container
# * * Hint: The user on the host needs to have the same ssh keys as the user in the container
# * * This is a little tricky to get your head around, but not too hard to implement
# * This also works for development machines (yay consistency!)
# * * I have briefly tested setting IntelliJ IDEA at this as the composer binary. An update worked - which is awesome!

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

# Make sure we have the first argument
if [[ $# -eq 0 ]] ; then
    echo "ERROR: No arguments supplied"
    exit 1
fi

# Work out the command
COMMAND=$@
if [ $1 == "update" ] || [ $1 == "install" ] || [ $1 == "require" ]; then
    COMMAND="${COMMAND} --ignore-platform-reqs --no-scripts"
fi

# Run composer in a container
#    --tty \
# --interactive \
docker run \
    --rm \
    --user $(id -u):$(id -g) \
    --env SSH_AUTH_SOCK=/ssh-auth.sock \
    --env HOME=$HOME \
    --volume $SSH_AUTH_SOCK:/ssh-auth.sock \
    --volume $HOME/.ssh:$HOME/.ssh:ro \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ${PWD}:/${PWD} \
    -w="${PWD}" \
    ${COMPOSER_IMAGE}:${COMPOSER_VERSION} \
    ${COMMAND}
