#!/usr/bin/env bash

NEXUS_URL="${NEXUS_URL:-http://localhost:8081}"
NEXUS_ADMIN_PASSWORD="${NEXUS_ADMIN_PASSWORD:-admin}"

echo "Disabling anonymous access."

curl \
  --request 'PUT' \
  --user "admin:${NEXUS_ADMIN_PASSWORD}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
    "enabled": false
  }' \
  "${NEXUS_URL}/service/rest/v1/security/anonymous" > /dev/null

