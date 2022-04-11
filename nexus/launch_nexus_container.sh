#!/usr/bin/env bash

NEXUS_IMAGE_NAME="${NEXUS_IMAGE_NAME:-nexus_playground}"
NEXUS_CONTAINER_NAME="${NEXUS_CONTAINER_NAME:-nexus}"
EXTRA_DOCKER_ARGS="${EXTRA_DOCKER_ARGS}"


CMD="docker run ${EXTRA_DOCKER_ARGS} --detach --name ${NEXUS_CONTAINER_NAME} ${NEXUS_IMAGE_NAME}"
echo "Launching Nexus container with: $CMD"
$CMD
