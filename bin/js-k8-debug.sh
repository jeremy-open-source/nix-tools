#!/usr/bin/env bash

kubectl run test -it --image=ubuntu:18.04 --restart=Never --rm
