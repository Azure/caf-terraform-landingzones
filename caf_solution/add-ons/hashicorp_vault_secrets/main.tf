terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.43"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.17.0"
    }
  }
  required_version = ">= 1.3.5"
}