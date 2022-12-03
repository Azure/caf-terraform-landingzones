provider "vault" {}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  # partner identifier for CAF Terraform landing zones.
  partner_id = "047b6579-da91-4bea-a9e1-df0fbc86f832"
}
data "azurerm_client_config" "current" {}
