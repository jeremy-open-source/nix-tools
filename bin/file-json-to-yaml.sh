#!/usr/bin/env bash

# See: https://www.commandlinefu.com/commands/view/12221/convert-json-to-yaml

FILE=$1
OLD_FILE="${FILE}.old"

cp ${FILE} ${OLD_FILE}
python -c 'import sys, yaml, json; yaml.safe_dump(json.load(sys.stdin), sys.stdout, default_flow_style=False)' < ${OLD_FILE} > ${FILE}
rm ${OLD_FILE}
