#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

if [ "${USE_DOCKER_BUILD_CACHE:-0}" -eq 1 ]; then
    DOCKER_BUILD_CACHE_OPTS=
else
    DOCKER_BUILD_CACHE_OPTS="--no-cache --pull"
fi

echo "Starting build of Docker image $DOCKER_IMAGE..."
docker build $DOCKER_BUILD_CACHE_OPTS \
             -t $DOCKER_IMAGE .

echo "Starting tests of Docker image $DOCKER_IMAGE..."
bats travis/tests
