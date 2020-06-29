
resource "azurecaf_naming_convention" "stg" {

  name          = var.storage_account_name
  resource_type = "azurerm_storage_account"
  convention    = var.convention
  prefix        = local.prefix
}


resource "azurerm_storage_account" "stg" {

  name                     = azurecaf_naming_convention.stg.result
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_kind             = "BlobStorage"
  account_tier             = "Standard"
  account_replication_type = "RAGRS"

  tags = {
    tfstate     = var.level
    environment = var.environment
    launchpad   = var.launchpad_mode
  }

  lifecycle {
    ignore_changes = [
      tags.launchpad
    ]
  }
}

resource "azurerm_storage_container" "launchpad" {
  name                  = "level0"
  storage_account_name  = azurerm_storage_account.stg.name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "role1_current_user" {
  scope                = azurerm_resource_group.rg.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.logged_user_objectId

  lifecycle {
    ignore_changes = [
      principal_id
    ]
  }
}