#!/bin/bash 
set -euo pipefail

export WORKSPACE=${WORKSPACE:-${BASH_SOURCE%/*}}
export APP_NAME=${APP_NAME:-searxng}

export SEARXNG_BASE_URL="${SEARXNG_BASE_URL?Need SEARXNG_BASE_URL (e.g. https://searxng.example.com)}"
export IPV6_ADDRESS="${IPV6_ADDRESS?Need IPV6_ADDRESS (e.g. fd00::2)}"
export IPV6_SUBNET="${IPV6_SUBNET?Need IPV6_SUBNET (e.g. fd00::1:0/120)}"
export IPV6_GATEWAY="${IPV6_GATEWAY?Need IPV6_GATEWAY (e.g. fd00::1:1)}"

cd $WORKSPACE || exit $?

echo "starting searxng with docker compose"
docker compose up -d
