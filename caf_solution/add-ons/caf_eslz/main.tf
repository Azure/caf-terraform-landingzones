
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55.0"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

