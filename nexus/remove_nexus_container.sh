#!/usr/bin/env bash

NEXUS_CONTAINER_NAME="${NEXUS_CONTAINER_NAME:-nexus}"

echo "Removing Nexus container: ${NEXUS_CONTAINER_NAME}"

docker rm --force --volumes "${NEXUS_CONTAINER_NAME}"

