#!/usr/bin/env bash

SCRIPT=$(readlink -f "$0")
DEFAULT_DOCKER_CONTEXT="$(dirname "$SCRIPT")/docker"
DOCKER_CONTEXT="${1:-$DEFAULT_DOCKER_CONTEXT}"
IMAGE_TAG="${2:-nexus_playground}"

echo "Building Nexus Docker image from ${DOCKER_CONTEXT} as ${IMAGE_TAG}."

docker build --quiet --tag "${IMAGE_TAG}" "${DOCKER_CONTEXT}"

