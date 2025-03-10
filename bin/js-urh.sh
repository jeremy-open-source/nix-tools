#!/usr/bin/env bash

set -eu -o pipefail

IMAGE="jopohl/urh"

sudo xhost +local:docker

docker pull ${IMAGE}

sudo docker run --rm \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v $HOME:/root \
  --privileged \
  ${IMAGE}
