#!/bin/bash
echo 'Configure vault backend secret config'
set -e
# vault secrets enable -path=${VAULT_SECRET_BACKEND} azure

vault write ${VAULT_SECRET_BACKEND}/config \
  subscription_id=${AZURE_SUBSCRIPTION_ID} \
  tenant_id=${AZURE_TENANT_ID} \
  client_id=${AZURE_CLIENT_ID} \
  client_secret=${AZURE_CLIENT_SECRET}

echo 'Read vault backend secret config'
vault read ${VAULT_SECRET_BACKEND}/config