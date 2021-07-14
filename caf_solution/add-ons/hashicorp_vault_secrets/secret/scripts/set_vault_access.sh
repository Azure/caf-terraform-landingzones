#!/bin/bash
echo 'Set vault access'
set -e

export VAULT_ADDR=${HASHICORP_VAULT_URL}
export VAULT_TOKEN=$(curl --insecure -X POST -d '{"role_id": "'"${HASHICORP_VAULT_ROLE_ID}"'", "secret_id": "'"${HASHICORP_VAULT_SECRET_ID}"'"}' ${HASHICORP_VAULT_URL}/v1/auth/approle/login  | jq -r '.auth.client_token')
export VAULT_SKIP_VERIFY=true