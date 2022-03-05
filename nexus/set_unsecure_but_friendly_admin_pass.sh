#!/usr/bin/env bash

NEXUS_CONTAINER_NAME="${2:-nexus}"
NEXUS_URL="http://localhost:8081"

DEFAULT_ADMIN_PASS=$(docker exec "${NEXUS_CONTAINER_NAME}" cat /nexus-data/admin.password)
NEW_PASSWORD="admin"

echo "Setting a friendly admin password."

curl \
  --request 'PUT' \
  --user "admin:${DEFAULT_ADMIN_PASS}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: text/plain' \
  --data "${NEW_PASSWORD}" \
     "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password"

