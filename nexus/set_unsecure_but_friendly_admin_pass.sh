#!/usr/bin/env bash

NEXUS_CONTAINER_NAME="${NEXUS_CONTAINER_NAME:-nexus}"
NEXUS_URL="${NEXUS_URL:-http://localhost:8081}"

DEFAULT_ADMIN_PASS=$(docker exec "${NEXUS_CONTAINER_NAME}" cat /nexus-data/admin.password)
NEXUS_ADMIN_PASSWORD="${NEXUS_ADMIN_PASSWORD:-admin}"

echo "Setting a friendly admin password."

curl \
  --request 'PUT' \
  --user "admin:${DEFAULT_ADMIN_PASS}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: text/plain' \
  --data "${NEXUS_ADMIN_PASSWORD}" \
     "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password"
