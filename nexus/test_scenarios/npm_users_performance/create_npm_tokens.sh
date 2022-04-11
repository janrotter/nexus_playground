#!/usr/bin/env bash
NEXUS_URL="${NEXUS_URL:-http://localhost:8081}"

for i in $(seq 1 5000); do
  if [[ $((i % 500)) -eq 0 ]]; then
    echo $i
    CURL_CMD="time curl"
  else
    CURL_CMD="curl"
  fi
  ${CURL_CMD} \
    --silent \
    --request 'PUT' \
    --user "user${i}:pass" \
    --silent \
    --header 'accept: application/json' \
    --header 'Content-Type: application/json' \
    --data '{"name":"user'${i}'", "password":"pass"}' ${NEXUS_URL}/repository/npm-proxy/-/user/org.couchdb.user:user${i} > /dev/null
  
done
