resource "azurerm_resource_group" "rg_appweb" {
  name     = "${local.prefix}${var.rg_app.web_tier.name}"
  location = local.global_settings.location_map.region1
  tags     = local.global_settings.tags_hub
}

resource "azurerm_resource_group" "rg_appapp" {
  name     = "${local.prefix}${var.rg_app.app_tier.name}"
  location = local.global_settings.location_map.region1
  tags     = local.global_settings.tags_hub
}

resource "azurerm_resource_group" "rg_appdb" {
  name     = "${local.prefix}${var.rg_app.db_tier.name}"
  location = local.global_settings.location_map.region1
  tags     = local.global_settings.tags_hub
}


resource "azurerm_availability_set" "as_web" {
  name                = var.web_tier.as.name
  location            = azurerm_resource_group.rg_appweb.location
  resource_group_name = azurerm_resource_group.rg_appweb.name
  tags                = merge(local.global_settings.tags_hub, var.web_tier.as.tags)
  platform_fault_domain_count = 2
}

resource "azurerm_lb" "ilb_web" {
  name                = var.web_tier.lb.name
  location            = azurerm_resource_group.rg_appweb.location
  resource_group_name = azurerm_resource_group.rg_appweb.name
  tags                = merge(local.global_settings.tags_hub, var.web_tier.lb.tags)

  frontend_ip_configuration {
    name                 = var.web_tier.lb.frontend_name
    private_ip_address_allocation = "Dynamic"
    subnet_id = lookup(module.net_core.core_network.vnet_subnets, "Web_tier", null)
  }
}

resource "azurerm_availability_set" "as_app" {
  name                = "as1-app"
  location            = azurerm_resource_group.rg_appapp.location
  resource_group_name = azurerm_resource_group.rg_appapp.name
  tags                = merge(local.global_settings.tags_hub, var.web_tier.as.tags)
  platform_fault_domain_count = 2
}

resource "azurerm_lb" "ilb-app" {
  name                = "ilb-app"
  location            = azurerm_resource_group.rg_appapp.location
  resource_group_name = azurerm_resource_group.rg_appapp.name

  frontend_ip_configuration {
    name                 = "PrivateIPAddress-ilb-app"
    private_ip_address_allocation = "Dynamic"
    subnet_id = lookup(module.net_core.core_network.vnet_subnets, "Business_tier", null)
  }
}

resource "azurerm_availability_set" "as_db" {
  name                = "as1-db"
  location            = azurerm_resource_group.rg_appdb.location
  resource_group_name = azurerm_resource_group.rg_appdb.name
  tags                = merge(local.global_settings.tags_hub, var.web_tier.as.tags)
  platform_fault_domain_count = 2
}

resource "azurerm_lb" "ilb-db" {
  name                = "ilb-db"
  location            = azurerm_resource_group.rg_appdb.location
  resource_group_name = azurerm_resource_group.rg_appdb.name

  frontend_ip_configuration {
    name                 = "PrivateIPAddress-ilb-db"
    private_ip_address_allocation = "Dynamic"
    subnet_id = lookup(module.net_core.core_network.vnet_subnets, "Data_tier", null)
  }
}
