locals {
  connectivity_subscription_id = can(var.custom_variables.virtual_hub_subscription_id) ? var.custom_variables.virtual_hub_subscription_id : data.azurerm_client_config.current.subscription_id
  connectivity_tenant_id       = can(var.custom_variables.virtual_hub_tenant_id) ? var.custom_variables.virtual_hub_tenant_id : data.azurerm_client_config.current.tenant_id
}
