terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.17.0"
    }
  }
  required_version = ">= 0.13"
}

