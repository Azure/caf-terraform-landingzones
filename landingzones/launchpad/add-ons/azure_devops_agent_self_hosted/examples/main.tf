provider "azurerm" {
    features {}
}

module "devops" {
    source = "../"

    prefix                  = local.prefix
    resource_group_name     = var.vm_object.resource_group.name
    location                = var.vm_object.resource_group.location
    subnet_id               = data.azurerm_subnet.agent.id
    storage_account_name    = lookup(var.vm_object, "storage_account_name", null)
    vm_object               = var.vm_object

    azure_devops_pat_token  = var.azure_devops_pat_token
    azure_devops            = var.azure_devops
    agent_init_script       = var.vm_object.agent_init_script

    acr_object              = var.acr_object

    log_analytics_workspace = azurerm_log_analytics_workspace.la
    diagnostics_map         =  module.diagnostics.diagnostics_map

}

data "azurerm_subnet" "agent" {
  depends_on = [ azurerm_subnet.level0, azurerm_subnet.level1 ]
  
  name                 = var.vm_object.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg_vnet.name
}

resource "random_string" "prefix" {
    length  = 4
    special = false
    upper   = false
    number  = false
}

locals {
  prefix  = var.use_prefix == true ? random_string.prefix.result : "" 
}

resource "azurecaf_naming_convention" "rg_vnet" {
  name          = "vnet"
  prefix        = local.prefix
  resource_type = "azurerm_resource_group"
  convention    = var.convention
}

resource "azurerm_resource_group" "rg_vnet" {
  name     = azurecaf_naming_convention.rg_vnet.result
  location = var.vm_object.resource_group.location
}

resource "azurecaf_naming_convention" "vnet" {
  name          = "vnet"
  prefix        = local.prefix
  resource_type = "azurerm_virtual_network"
  convention    = var.convention
}

resource "azurerm_virtual_network" "vnet" {
  name                = azurecaf_naming_convention.vnet.result
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = ["10.0.0.0/16"]

}

resource "azurerm_subnet" "level0" {
  name                 = "level0"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.0.0/26"
}

resource "azurerm_subnet" "level1" {
  name                 = "level1"
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.0.0.64/26"
}

resource "azurecaf_naming_convention" "la" {
  name          = "test"
  prefix        = local.prefix
  resource_type = "azurerm_log_analytics_workspace"
  convention    = var.convention
}

resource "azurerm_log_analytics_workspace" "la" {
  name                = azurecaf_naming_convention.la.result
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

locals {
    azure_diagnostics_logs_event_hub = false
}

module "diagnostics" {
  source  = "aztfmod/caf-diagnostics-logging/azurerm"
  version = "~> 2.0.1"

  name                  = "diag"
  convention            = var.convention
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  prefix                = local.prefix
  tags                  = {}

  enable_event_hub      = local.azure_diagnostics_logs_event_hub
}