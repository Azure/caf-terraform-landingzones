
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.02"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.29.0"
    }

  }
  required_version = ">= 0.14"
  experiments      = [module_variable_optional_attrs]
}


provider "azurerm" {
  # partner identifier for CAF Terraform landing zones.
  features {}
}

data "azurerm_client_config" "current" {}
