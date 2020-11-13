#!/usr/bin/env bash

set -e

URI=${1:-"http://127.0.0.1"}
echo "INFO: Testing '${URI}'"

while true ; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${URI}"  | xargs)
    if [ "${STATUS}" != "200" ]; then
      echo "Failed! '${STATUS}'"
      break 
    fi
    echo "Success '${STATUS}'"
    sleep 0.1
done
