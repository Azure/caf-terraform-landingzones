terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.82.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~> 0.3.9"
    }
  }
  required_version = ">= 1.3.5"
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "current" {}

locals {
  azure_workspace_resource = local.remote.databricks_workspaces[var.databricks_workspace.lz_key][var.databricks_workspace.workspace_key]
}

provider "databricks" {
  host = local.azure_workspace_resource.workspace_url
}
