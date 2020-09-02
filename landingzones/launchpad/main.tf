terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.25.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 0.10.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    azurecaf = {
      source = "aztfmod/azurecaf"
      version = "~>0.4.3"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {}
}


data "azurerm_subscription" "primary" {}
data "azurerm_client_config" "current" {}


resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  number  = false
}

resource "random_string" "alpha1" {
  length  = 1
  special = false
  upper   = false
  number  = false
}

locals {
  landingzone_tag = {
    landingzone = var.launchpad_mode
  }
  tags = merge(var.tags, local.landingzone_tag, { "level" = var.level }, { "environment" = var.environment }, { "rover_version" = var.rover_version })

  global_settings = {
    prefix            = local.prefix
    convention        = var.convention
    default_location  = var.location
    environment       = var.environment
  }

  prefix             = var.prefix == null ? random_string.prefix.result : var.prefix
  prefix_with_hyphen = local.prefix == "" ? "" : "${local.prefix}-"
  prefix_start_alpha = local.prefix == "" ? "" : "${random_string.alpha1.result}${local.prefix}"
}