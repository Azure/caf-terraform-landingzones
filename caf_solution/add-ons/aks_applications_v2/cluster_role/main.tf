terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
    }
  }
}