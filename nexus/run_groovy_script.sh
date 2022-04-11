#!/usr/bin/env bash

NEXUS_URL="${NEXUS_URL:-http://localhost:8081}"
NEXUS_ADMIN_PASSWORD="${NEXUS_ADMIN_PASSWORD:-admin}"
CUSTOM_SCRIPT_FILE_PATH="${CUSTOM_SCRIPT_FILE_PATH:-/tmp/custom_script}"
CUSTOM_SCRIPT_NAME="custom_script"

echo "Running custom script from ${CUSTOM_SCRIPT_FILE_PATH}"

curl \
  --request 'DELETE' \
  --user "admin:${NEXUS_ADMIN_PASSWORD}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  "${NEXUS_URL}/service/rest/v1/script/${CUSTOM_SCRIPT_NAME}"


CURL_DATA_FILE=$(mktemp /tmp/nexus_groovy_script.XXX)
echo '{}' | jq \
  --rawfile script_content "${CUSTOM_SCRIPT_FILE_PATH}" \
  '. + {type: "groovy", name: "'"${CUSTOM_SCRIPT_NAME}"'", content: $script_content}' > "$CURL_DATA_FILE"

curl \
  --request 'POST' \
  --user "admin:${NEXUS_ADMIN_PASSWORD}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  --data-binary @"${CURL_DATA_FILE}" \
  "${NEXUS_URL}/service/rest/v1/script" > /dev/null
rm "$CURL_DATA_FILE"

echo "Result:"
curl \
  --request 'POST' \
  --user "admin:${NEXUS_ADMIN_PASSWORD}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: text/plain' \
  --data '' \
  "${NEXUS_URL}/service/rest/v1/script/${CUSTOM_SCRIPT_NAME}/run" | jq .result

