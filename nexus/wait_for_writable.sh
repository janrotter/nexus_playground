#!/usr/bin/env bash

NEXUS_URL="http://localhost:8081"

check_writable() {
  curl -X 'GET' \
       -H 'accept: application/json' \
       --silent \
       "${NEXUS_URL}/service/rest/v1/status/writable"
  RETVAL=$?
}

echo "Waiting for Nexus to become writable."

check_writable
while [ $RETVAL -ne 0 ]; do
  check_writable
  sleep 1
done

