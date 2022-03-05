#!/usr/bin/env bash

NEXUS_IMAGE_NAME="${1:-nexus_playground}"
NEXUS_CONTAINER_NAME="${2:-nexus}"
ADDITIONAL_FLAGS="${*:3}"


CMD="docker run ${ADDITIONAL_FLAGS} --rm --detach --name ${NEXUS_CONTAINER_NAME} ${NEXUS_IMAGE_NAME}"
echo "Launching Nexus container with: $CMD"
$CMD

