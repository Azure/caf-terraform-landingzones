
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65.0"
    }
  }
  required_version = ">= 0.14"
  experiments = [module_variable_optional_attrs]
}


provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}
