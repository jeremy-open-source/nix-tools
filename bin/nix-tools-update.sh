#!/usr/bin/env bash

set -e

# This script updates everything

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

docker pull ${COMPOSER_IMAGE}:${COMPOSER_VERSION}
docker pull ${PHPUNIT_IMAGE}:${PHPUNIT_VERSION}
