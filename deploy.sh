#!/bin/bash 
set -euo pipefail

export WORKSPACE=${WORKSPACE:-${BASH_SOURCE%/*}}
export APP_NAME=${APP_NAME:-searxng}

cd $WORKSPACE || exit $?

echo "starting searxng with docker compose"
docker compose up -d
