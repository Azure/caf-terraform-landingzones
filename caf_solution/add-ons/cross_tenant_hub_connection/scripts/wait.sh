#!/bin/bash

set -e

function canonicalize() {
  echo $@ | sed 's|//subscriptions|/subscriptions|'
}

API_VERSION=2021-02-01

RAW_URL=${resourceManager}/${VIRTUAL_HUB_ID}?api-version=${API_VERSION}

URL=$(canonicalize ${RAW_URL})
echo ${URL}

PROVISIONING_STATE=$(az rest --method GET --uri ${URL} --query properties.provisioningState -o tsv)

while ${PROVISIONING_STATE} != "Succeeded"
do
  sleep 30
  PROVISIONING_STATE=$(az rest --method GET --uri ${URL} --query properties.provisioningState -o tsv)
done

echo "Virtual Hub is ready"
