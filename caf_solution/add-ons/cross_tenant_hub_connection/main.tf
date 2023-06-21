
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
  }
  required_version = ">= 1.3.5"
}


# provider "azurerm" {
#   features {}
#   skip_provider_registration = true
# }

# data "azurerm_client_config" "current" {}

