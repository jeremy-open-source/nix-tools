#!/usr/bin/env bash

set -e

IMAGE=$(cat Dockerfile | sed -n -e '/^FROM/p' | cut -c6-)
SHELL=${1:-bash}
DIR=$(pwd)
ADDITIONAL_ARGS=""
PROJECT_HOME="/opt/project"
USER="root"

COMMAND="docker run --rm -it --user ${USER} -v ${DIR}:${PROJECT_HOME} ${ADDITIONAL_ARGS} ${IMAGE} ${SHELL}"
echo "Running command: ${COMMAND}"
eval $COMMAND
