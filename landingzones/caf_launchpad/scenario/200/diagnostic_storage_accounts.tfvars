# Defines different repositories for the diagnostics logs
# Storage accounts, log analytics, event hubs

diagnostic_storage_accounts = {
  # Stores diagnostic logging for region1
  diaglogs_region1 = {
    name                     = "diaglogsrg1"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for region2
  diaglogs_region2 = {
    name                     = "diaglogrg2"
    region                   = "region2"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores security logs for siem default region"
  diagsiem_region1 = {
    name                     = "siemsg1"
    resource_group_key       = "siem"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores diagnostic logging for region2
  diagsiem_region2 = {
    name                     = "siemrg2"
    region                   = "region2"
    resource_group_key       = "siem"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootrg1"
    region                   = "region1"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
  # Stores boot diagnostic for region2
  bootdiag_region2 = {
    name                     = "bootrg2"
    region                   = "region2"
    resource_group_key       = "ops"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}