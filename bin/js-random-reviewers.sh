#!/usr/bin/env bash

FILE=~/reviewers.json
NUMBER=${1:-3}
AREA=${2:-"default"}

cat ~/reviewers.json | jq -jr .${AREA} | jq -r '.[]' | shuf -n ${NUMBER}
