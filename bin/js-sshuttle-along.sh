#!/usr/bin/env bash

set -e

SERVER=${1:-""}
if [[ -z "${SERVER}" ]] ; then
  read -r -p "Server (i.e. 'user@host') :" SERVER
fi

LOCATION=${2:-""}
if [[ -z "${LOCATION}" ]] ; then
  read -r -p "Location (i.e. '0.0.0.0/0') :" LOCATION
fi



sshuttle -e "ssh " -r "${SERVER}" "${LOCATION}"
