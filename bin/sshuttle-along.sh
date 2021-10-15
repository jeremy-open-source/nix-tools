#!/usr/bin/env bash

set -e

LOCATION=${1:-""}
if [[ -z "${LOCATION}" ]] ; then
  read -r -p "Location (i.e. 'user@host') :" LOCATION
fi

sshuttle -e "ssh " -r "${LOCATION}" 0.0.0.0/0
