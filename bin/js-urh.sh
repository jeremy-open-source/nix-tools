#!/usr/bin/env bash

set -e

sudo xhost +local:docker

sudo docker run --rm        -e DISPLAY=${DISPLAY}        -v /tmp/.X11-unix:/tmp/.X11-unix        -v $HOME:/root        --privileged        jopohl/urh
