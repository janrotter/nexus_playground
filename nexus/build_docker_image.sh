#!/usr/bin/env bash

SCRIPT=$(readlink -f "$0")
DEFAULT_DOCKER_CONTEXT="$(dirname "$SCRIPT")/docker"
NEXUS_DOCKER_CONTEXT="${NEXUS_DOCKER_CONTEXT:-$DEFAULT_DOCKER_CONTEXT}"
NEXUS_IMAGE_NAME="${NEXUS_IMAGE_NAME:-nexus_playground}"

echo "Building Nexus Docker image from ${NEXUS_DOCKER_CONTEXT} as ${NEXUS_IMAGE_NAME}."

docker build --quiet --tag "${NEXUS_IMAGE_NAME}" "${NEXUS_DOCKER_CONTEXT}"

