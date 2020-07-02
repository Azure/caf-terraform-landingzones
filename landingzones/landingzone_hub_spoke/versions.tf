terraform {
  required_providers {
    azurecaf = {
      # source = "aztfmod/azurecaf"
      # source supported only on Terraform > 0.13
      # version = "0.4.3"
    }
    azurerm = {
      # source = "hashicorp/azurerm"
      version = "~>2.16.0"
    }
    terraform = {
      # source = "hashicorp/terraform"
    }
  }
}

