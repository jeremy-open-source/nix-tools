#!/usr/bin/env bash

set -e

while true ; do
    sleep 0.1
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:5000/operations/healthcheck/readiness | xargs)
    if [ "${STATUS}" != "200" ]; then
      echo "Failed! ${STATUS}"
      # break 
      continue 
    fi
    echo "Success ${STATUS}"
done
