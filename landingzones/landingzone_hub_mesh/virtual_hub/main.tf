terraform {
  backend "azurerm" {
  }
}

data "azurerm_subscription" "current" {
}

locals {
  blueprint_tag = {
    "blueprint" = basename(abspath(path.module))
  }
  tags = merge(var.global_settings.tags_hub, local.blueprint_tag)
}

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

