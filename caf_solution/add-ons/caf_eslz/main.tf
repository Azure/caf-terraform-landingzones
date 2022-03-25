terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.96.0"
    }
  }
  required_version = ">= 0.14"
  experiments      = [module_variable_optional_attrs]
}

# Core provider block
provider "azurerm" {
  # Partner identifier for CAF Terraform landing zones.
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  features {}
}

# Declare an aliased provider block using your preferred configuration.
# This will be used for the deployment of all "Connectivity resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = coalesce(var.subscription_id_connectivity, null)
  features {}
}

# Declare a standard provider block using your preferred configuration.
# This will be used for the deployment of all "Management resources" to the specified `subscription_id`.
provider "azurerm" {
  alias           = "management"
  subscription_id = coalesce(var.subscription_id_management, null)
  features {}
}

data "azurerm_client_config" "core" {
  provider = azurerm
}

data "azurerm_client_config" "management" {
  provider = azurerm.management
}

data "azurerm_client_config" "connectivity" {
  provider = azurerm.connectivity
}
