#!/usr/bin/env bash

set -e

JQ_ARGS=".message" # ".message,.onBehalfOf"
if [[ "$2" ]]; then
    JQ_ARGS=$2
fi

# FIND ENVIRONMENT
CONTEXT="development"
if [[ "$3" ]]; then
    CONTEXT=$3
fi
echo "Starting kubernetes proxy for context ${CONTEXT}"

kubectl logs --context="${CONTEXT}" -f deployment/$1 2>&1 | grep "{" | jq ${JQ_ARGS}
