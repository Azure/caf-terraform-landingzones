terraform {
  required_providers {
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
    azapi = {
      source = "Azure/azapi"
    }
  }

}

locals {
  tags         = merge(var.base_tags, try(var.settings.tags, null))
}