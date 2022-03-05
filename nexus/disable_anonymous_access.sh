#!/usr/bin/env bash

NEXUS_URL="http://localhost:8081"

echo "Disabling anonymous access."

curl \
  --request 'PUT' \
  --user admin:admin \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{
    "enabled": false
  }' \
  "${NEXUS_URL}/service/rest/v1/security/anonymous"

