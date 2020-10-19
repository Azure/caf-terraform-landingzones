terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.30.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 2.2.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 1.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 2.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 2.2.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~>1.1.0"
    }
  }
  required_version = ">= 0.13"
}


provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "current_networking" {
  for_each = try(var.landingzone.current.networking, {})

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = var.tfstate_storage_account_name
    container_name       = var.tfstate_container_name
    resource_group_name  = var.tfstate_resource_group_name
    key                  = each.value.tfstate
  }
}

data "terraform_remote_state" "lower_networking" {
  for_each = try(var.landingzone.lower.networking, {})

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = var.lower_storage_account_name
    container_name       = var.lower_container_name
    resource_group_name  = var.lower_resource_group_name
    key                  = each.value.tfstate
  }
}

data "terraform_remote_state" "foundations" {
  backend = var.landingzone.backend_type
  config = {
    storage_account_name = var.lower_storage_account_name
    container_name       = var.lower_container_name
    resource_group_name  = var.lower_resource_group_name
    key                  = var.landingzone.lower.foundations.tfstate
  }
}


locals {
  landingzone_tag = {
    "landingzone" = basename(abspath(path.module))
  }
  tags = merge(local.landingzone_tag, { "level" = var.landingzone.current.level }, { "environment" = local.global_settings.environment }, { "rover_version" = var.rover_version }, var.tags)

  global_settings = {
    prefix             = try(var.global_settings.prefix, data.terraform_remote_state.foundations.outputs.global_settings.prefix)
    prefix_with_hyphen = try(var.global_settings.prefix_with_hyphen, data.terraform_remote_state.foundations.outputs.global_settings.prefix_with_hyphen)
    prefix_start_alpha = try(var.global_settings.prefix_start_alpha, data.terraform_remote_state.foundations.outputs.global_settings.prefix_start_alpha)
    default_region     = try(var.global_settings.default_region, data.terraform_remote_state.foundations.outputs.global_settings.default_region)
    regions            = try(var.global_settings.regions, null) == null ? data.terraform_remote_state.foundations.outputs.global_settings.regions : merge(data.terraform_remote_state.foundations.outputs.global_settings.regions, var.global_settings.regions)
    environment        = data.terraform_remote_state.foundations.outputs.global_settings.environment
    random_length      = try(var.global_settings.random_length, data.terraform_remote_state.foundations.outputs.global_settings.random_length)
    passthrough        = try(var.global_settings.passthrough, data.terraform_remote_state.foundations.outputs.global_settings.passthrough)
  }

  diagnostics = {
    diagnostics_definition   = merge(data.terraform_remote_state.foundations.outputs.diagnostics.diagnostics_definition, var.diagnostics_definition)
    diagnostics_destinations = data.terraform_remote_state.foundations.outputs.diagnostics.diagnostics_destinations
    storage_accounts         = data.terraform_remote_state.foundations.outputs.diagnostics.storage_accounts
    log_analytics            = data.terraform_remote_state.foundations.outputs.diagnostics.log_analytics
  }

  # Merge all remote networking objects
  lower_networking = {
    for key, networking in try(var.landingzone.lower.networking, {}) : key => merge(data.terraform_remote_state.lower_networking[key].outputs.networking[key])
  }
  current_networking = {
    for key, networking in try(var.landingzone.current.networking, {}) : key => merge(data.terraform_remote_state.current_networking[key].outputs.networking[key])
  }


  tfstates = merge(
    map(var.landingzone.current.key,
      map(
        "storage_account_name", var.tfstate_storage_account_name,
        "container_name", var.tfstate_container_name,
        "resource_group_name", var.tfstate_resource_group_name,
        "key", var.tfstate_key,
        "level", var.landingzone.current.level,
        "tenant_id", data.azurerm_client_config.current.tenant_id,
        "subscription_id", data.azurerm_client_config.current.subscription_id
      )
    )
    ,
    data.terraform_remote_state.foundations.outputs.tfstates
  )


}
