
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.29.0"
    }
  }
  required_version = ">= 1.1.0"
  # experiments      = [module_variable_optional_attrs]
}


provider "azurerm" {
  
  # partner identifier for CAF Terraform landing zones.
  partner_id = 047b6579-da91-4bea-a9e1-df0fbc86f832

  # blinQ: Workaround to solve temporarly issue with provider registration
  skip_provider_registration = true

  features {}
}

data "azurerm_client_config" "current" {}
