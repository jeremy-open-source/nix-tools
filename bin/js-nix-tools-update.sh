#!/usr/bin/env bash

set -eu -o pipefail

# This script updates everything

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
source "${DIR}/../.env"

# Pull Composer
docker pull ${COMPOSER_IMAGE}:${COMPOSER_VERSION}

# Pull PHP-Unit
docker pull ${PHPUNIT_IMAGE}:${PHPUNIT_VERSION}

# Pull Terraform
docker pull ${TERRAFORM_IMAGE}:${TERRAFORM_VERSION}

# Build the docker-compose
docker-compose \
    --file "${DIR}/../docker-compose.yml" \
    --project-directory "${DIR}/.." \
    build --pull
