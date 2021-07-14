#!/usr/bin/env bash

set -e

JOB_ID=${1:-""}
if [[ -z "${JOB_ID}" ]] ; then
  read -r -p "Job id (i.e. uuid) :" JOB_ID
fi

aws batch \
    --region eu-west-1 \
    describe-jobs \
    --jobs "${JOB_ID}"
