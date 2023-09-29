terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }

}

locals {
  tags         = merge(var.base_tags, try(var.settings.tags, null))


  managed_local_identities = flatten([
    for managed_identity_key in try(var.settings.identity.managed_identity_keys, []) : [
      var.combined_resources.managed_identities[var.client_config.landingzone_key][managed_identity_key].id
    ]
  ])

  managed_remote_identities = flatten([
    for lz_key, value in try(var.settings.identity.remote, []) : [
      for managed_identity_key in value.managed_identity_keys : [
        var.combined_resources.managed_identities[lz_key][managed_identity_key].id
      ]
    ]
  ])

  provided_identities = try(var.settings.identity.managed_identity_ids, [])

  managed_identities = concat(local.provided_identities, local.managed_local_identities, local.managed_remote_identities)

  secrets = flatten([
    for secret in try(var.settings.secrets, null) : [
      {
        name          = secret.name
        value         = try(secret.value, null)
        identity      = try(try(secret.managed_identity_id, var.combined_resources.managed_identities[try(secret.managed_identity.lz_key, var.client_config.landingzone_key)][try(secret.managed_identity_key, secret.managed_identity.key)].id), null)
        keyVaultUrl   = try(
          try(
            secret.keyvault_url, 
            format("%ssecrets/%s", var.combined_resources.keyvaults[try(secret.keyvault.lz_key, var.client_config.landingzone_key)][try(secret.keyvault_key, secret.keyvault.key)].vault_uri, try(var.combined_resources.dynamic_keyvault_secrets[try(secret.keyvault_key, secret.keyvault.key)][secret.dynamic_keyvault_secret_key].secret_name, try(secret.keyvault_secret_name, null)))
          )
        , null)
      }
    ] if can(secret.value) || can(try(secret.managed_identity_id, try(secret.managed_identity_key, secret.managed_identity.key)))
  ])
}
