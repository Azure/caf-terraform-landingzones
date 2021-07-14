#!/bin/bash
echo 'Configure vault backend secret config'
set -e
# vault secrets enable -path=${VAULT_SECRET_BACKEND} azure

export VAULT_ADDR=${HASHICORP_VAULT_URL}
export VAULT_TOKEN=$(curl --insecure -X POST -d '{"role_id": "'"${HASHICORP_VAULT_ROLE_ID}"'", "secret_id": "'"${HASHICORP_VAULT_SECRET_ID}"'"}' ${HASHICORP_VAULT_URL}/v1/auth/approle/login  | jq -r '.auth.client_token')
export VAULT_SKIP_VERIFY=true

vault write ${VAULT_SECRET_BACKEND}/config \
  subscription_id=${AZURE_SUBSCRIPTION_ID} \
  tenant_id=${AZURE_TENANT_ID} \
  client_id=${AZURE_CLIENT_ID} \
  client_secret=${AZURE_CLIENT_SECRET}

echo 'Read vault backend secret config'
vault read ${VAULT_SECRET_BACKEND}/config