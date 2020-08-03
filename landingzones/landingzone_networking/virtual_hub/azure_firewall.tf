# While the Azure Firewall object is using ARM template snippet, we store each object in a different RG to simplify lifecycles
resource "azurecaf_naming_convention" "rg_virtualhub_fw" {
  count         = var.virtual_hub_config.deploy_firewall ? 1 : 0
  name          = var.virtual_hub_config.firewall_resource_groupe_name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_resource_group"
  convention    = var.global_settings.convention
}

resource "azurerm_resource_group" "rg_virtualhub_fw" {
  depends_on = [azurerm_virtual_hub.vwan_hub] #adding explicit dependency for destroy time since we use ARM template.
  count      = var.virtual_hub_config.deploy_firewall ? 1 : 0
  name       = azurecaf_naming_convention.rg_virtualhub_fw.0.result
  location   = var.virtual_hub_config.region
  tags       = local.tags
}

resource "azurecaf_naming_convention" "virtualhub_fw" {
  count         = var.virtual_hub_config.deploy_firewall ? 1 : 0
  name          = var.virtual_hub_config.firewall_name
  prefix        = var.prefix != "" ? var.prefix : null
  resource_type = "azurerm_virtual_network"
  convention    = var.global_settings.convention
}

# As per https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-09-01/azurefirewalls
resource "azurerm_template_deployment" "arm_template_vhub_firewall" {
  count               = var.virtual_hub_config.deploy_firewall ? 1 : 0
  name                = var.virtual_hub_config.firewall_name
  resource_group_name = azurerm_resource_group.rg_virtualhub_fw.0.name

  template_body = file("${path.module}/arm_template_vhub_firewall.json")

  parameters = {
    "vwan_id"  = azurerm_virtual_hub.vwan_hub.id,
    "name"     = var.virtual_hub_config.firewall_name,
    "location" = var.location,
    "Tier"     = "Standard",
  }
  deployment_mode = "Incremental"
}
