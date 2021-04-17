
# Store output attributes into keyvault secret
# Those values are used by the rover to connect the current remote state and
# identity the lower level
dynamic_keyvault_secrets = {
  level0 = {
    msi = {
      output_key    = "managed_identities"
      resource_key  = "level0"
      attribute_key = "id"
      secret_name   = "msi-resource-id"
    }
    subscription_id = {
      output_key    = "client_config"
      attribute_key = "subscription_id"
      secret_name   = "subscription-id"
    }
    tenant_id = {
      output_key    = "client_config"
      attribute_key = "tenant_id"
      secret_name   = "tenant-id"
    }
    admin = {
      secret_name = "azdo-pat-admin"
      value       = ""
    }
    agent = {
      secret_name = "azdo-pat-agent"
      value       = ""
    }
  }
  level1 = {
    msi = {
      output_key    = "managed_identities"
      resource_key  = "level1"
      attribute_key = "id"
      secret_name   = "msi-resource-id"
    }
    lower_stg = {
      output_key    = "storage_accounts"
      resource_key  = "level0"
      attribute_key = "name"
      secret_name   = "lower-storage-account-name"
    }
    lower_rg = {
      output_key    = "resource_groups"
      resource_key  = "level0"
      attribute_key = "name"
      secret_name   = "lower-resource-group-name"
    }
    subscription_id = {
      output_key    = "client_config"
      attribute_key = "subscription_id"
      secret_name   = "subscription-id"
    }
    tenant_id = {
      output_key    = "client_config"
      attribute_key = "tenant_id"
      secret_name   = "tenant-id"
    }
  }
  level2 = {
    msi = {
      output_key    = "managed_identities"
      resource_key  = "level2"
      attribute_key = "id"
      secret_name   = "msi-resource-id"
    }
    lower_stg = {
      output_key    = "storage_accounts"
      resource_key  = "level1"
      attribute_key = "name"
      secret_name   = "lower-storage-account-name"
    }
    lower_rg = {
      output_key    = "resource_groups"
      resource_key  = "level1"
      attribute_key = "name"
      secret_name   = "lower-resource-group-name"
    }
    subscription_id = {
      output_key    = "client_config"
      attribute_key = "subscription_id"
      secret_name   = "subscription-id"
    }
    tenant_id = {
      output_key    = "client_config"
      attribute_key = "tenant_id"
      secret_name   = "tenant-id"
    }
  }
  level3 = {
    msi = {
      output_key    = "managed_identities"
      resource_key  = "level3"
      attribute_key = "id"
      secret_name   = "msi-resource-id"
    }
    lower_stg = {
      output_key    = "storage_accounts"
      resource_key  = "level2"
      attribute_key = "name"
      secret_name   = "lower-storage-account-name"
    }
    lower_rg = {
      output_key    = "resource_groups"
      resource_key  = "level2"
      attribute_key = "name"
      secret_name   = "lower-resource-group-name"
    }
    subscription_id = {
      output_key    = "client_config"
      attribute_key = "subscription_id"
      secret_name   = "subscription-id"
    }
    tenant_id = {
      output_key    = "client_config"
      attribute_key = "tenant_id"
      secret_name   = "tenant-id"
    }
  }
  level4 = {
    msi = {
      output_key    = "managed_identities"
      resource_key  = "level4"
      attribute_key = "id"
      secret_name   = "msi-resource-id"
    }
    lower_stg = {
      output_key    = "storage_accounts"
      resource_key  = "level3"
      attribute_key = "name"
      secret_name   = "lower-storage-account-name"
    }
    lower_rg = {
      output_key    = "resource_groups"
      resource_key  = "level3"
      attribute_key = "name"
      secret_name   = "lower-resource-group-name"
    }
    subscription_id = {
      output_key    = "client_config"
      attribute_key = "subscription_id"
      secret_name   = "subscription-id"
    }
    tenant_id = {
      output_key    = "client_config"
      attribute_key = "tenant_id"
      secret_name   = "tenant-id"
    }
  }
}