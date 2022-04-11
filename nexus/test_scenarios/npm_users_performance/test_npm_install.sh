#!/usr/bin/env bash
NEXUS_URL="${NEXUS_URL:-http://localhost:8081}"
NEXUS_ADMIN_PASSWORD="${NEXUS_ADMIN_PASSWORD:-admin}"

NPM_TOKEN=$(curl \
  --silent \
  --request 'PUT' \
  --user "admin:${NEXUS_ADMIN_PASSWORD}" \
  --silent \
  --header 'accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{"name":"admin", "password":"'${NEXUS_ADMIN_PASSWORD}'"}' ${NEXUS_URL}/repository/npm-proxy/-/user/org.couchdb.user:admin | jq .token)

docker run --rm --link nexus node bash -c \
  "cd && echo 'registry=http://nexus:8081/repository/npm-proxy' > .npmrc && echo '//nexus:8081/repository/:_authToken=${NPM_TOKEN}' >> .npmrc && time npm i constructs"
