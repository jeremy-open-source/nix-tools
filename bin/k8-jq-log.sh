#!/usr/bin/env bash

# FIND ENVIRONMENT
CONTEXT="development"
if [[ "$1" ]]; then
    CONTEXT=$1
fi

echo "Starting kubernetes proxy for context ${CONTEXT}"
kubectl config use-context ${CONTEXT}

kubectl logs deployment/$2 | grep "{" | jq .message
