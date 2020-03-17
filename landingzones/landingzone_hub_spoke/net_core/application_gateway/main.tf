
terraform{
required_version = ">= 0.12"
}
 
provider "azurerm"{
version = "<= 2.1"
  features {}
}

# locals {
#   blueprint_tag          = {
#     "blueprint" = basename(abspath(path.module))
#   }
#   tags                = merge(var.global_settings.tags_hub,local.blueprint_tag)
# }