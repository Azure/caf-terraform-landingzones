
storage_accounts = {
  # Is used to store the azure devops deployment script to setup the Azure Devops Selfhosted agents
  scripts_region1 = {
    name                     = "scriptsl1"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    allow_blob_public_access = true

    containers = {
      scripts = {
        name                  = "deployment-scripts"
        container_access_type = "blob"
      }
    }
  }
}

# Attributes available https://www.terraform.io/docs/providers/azurerm/r/storage_blob.html
storage_account_blobs = {
  devops_runtime_baremetal = {
    storage_account_key    = "scripts_region1"
    storage_container_name = "deployment-scripts"
    name                   = "devops_runtime_baremetal.sh"
    source                 = "scripts/devops_runtime_baremetal.sh"
  }
}

diagnostic_storage_accounts = {
  # Stores boot diagnostic for region1
  bootdiag_region1 = {
    name                     = "bootl1"
    resource_group_key       = "rg1"
    account_kind             = "StorageV2"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Cool"
  }
}

