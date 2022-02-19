terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0.2"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "~> 0.5.0"
    }
  }
  required_version = ">= 0.13"
}

data "azurerm_client_config" "current" {}
