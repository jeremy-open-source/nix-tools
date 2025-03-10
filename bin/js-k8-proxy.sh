#!/bin/bash

set -eu -o pipefail

# TODO: Add a trap

# FIND THE PROXY URI
PROXY_URL="http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/login"

# FIND ENVIRONMENT
CONTEXT="development"
if [[ "$1" ]]; then
    CONTEXT=$1
fi

# FIND A OPEN EXECUTABLE
if [ -x "$(command -v xdg-open)" ]; then
  BROWSER_COMMAND="xdg-open"
elif [ -x "$(command -v open)" ]; then
  BROWSER_COMMAND="open"
else
  echo "ERROR: Could not find a suitable open executable"
fi

# FIND A COPY TO CLIPBOARD EXECUTABLE
if [ -x "$(command -v xclip)" ]; then
  COPY_COMMAND="xclip -selection clipboard"
elif [ -x "$(command -v pbcopy)" ]; then
  COPY_COMMAND="pbcopy"
else
  echo "ERROR: Could not find a suitable copy to clipboard executable"
fi

echo "Starting kubernetes proxy for context ${CONTEXT}"
kubectl config use-context ${CONTEXT}
kubectl proxy &
PROXY_PID=$!

TOKEN_KEY=$(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
TOKEN=$(kubectl -n kube-system describe secret ${TOKEN_KEY} | grep token: | awk '{print $2}')

echo "${TOKEN}" | ${COPY_COMMAND}
echo "The proxy login token has been copied to the clipboard."

${BROWSER_COMMAND} ${PROXY_URL} &

read -p "Press Enter to stop the kubernetes proxy (${PROXY_PID})"

kill ${PROXY_PID}
