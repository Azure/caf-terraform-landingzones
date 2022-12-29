terraform {
  required_providers {
    // azurerm version driven by the caf module
    // azuread version driven by the caf module
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.0"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.1.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azuread" {
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
}

provider "azurerm" {
  partner_id = "ca4078f8-9bc4-471b-ab5b-3af6b86a42c8"
  # partner identifier for CAF Terraform landing zones.
  features {
    api_management {
      purge_soft_delete_on_destroy         = var.provider_azurerm_features_api_management.purge_soft_delete_on_destroy
      # recover_soft_deleted_api_managements = var.provider_azurerm_features_api_management.recover_soft_deleted_api_managements
    }
    # application_insights {
    #   disable_generated_rule = var.provider_azurerm_features_application_insights.disable_generated_rule
    # }
    cognitive_account {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_cognitive_account.purge_soft_delete_on_destroy
    }
    key_vault {
      purge_soft_delete_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_delete_on_destroy
      # purge_soft_deleted_certificates_on_destroy = var.provider_azurerm_features_keyvault.purge_soft_deleted_certificates_on_destroy
      # purge_soft_deleted_keys_on_destroy         = var.provider_azurerm_features_keyvault.purge_soft_deleted_keys_on_destroy
      # purge_soft_deleted_secrets_on_destroy      = var.provider_azurerm_features_keyvault.purge_soft_deleted_secrets_on_destroy
      # recover_soft_deleted_certificates          = var.provider_azurerm_features_keyvault.recover_soft_deleted_certificates
      # recover_soft_deleted_key_vaults            = var.provider_azurerm_features_keyvault.recover_soft_deleted_key_vaults
      # recover_soft_deleted_keys                  = var.provider_azurerm_features_keyvault.recover_soft_deleted_keys
      # recover_soft_deleted_secrets               = var.provider_azurerm_features_keyvault.recover_soft_deleted_secrets
    }
    # log_analytics_workspace {
    #   permanently_delete_on_destroy = var.provider_azurerm_features_log_analytics_workspace.permanently_delete_on_destroy
    # }
    resource_group {
      prevent_deletion_if_contains_resources = var.provider_azurerm_features_resource_group.prevent_deletion_if_contains_resources
    }
    template_deployment {
      delete_nested_items_during_deletion = var.provider_azurerm_features_template_deployment.delete_nested_items_during_deletion
    }
    virtual_machine {
      delete_os_disk_on_deletion     = var.provider_azurerm_features_virtual_machine.delete_os_disk_on_deletion
      graceful_shutdown              = var.provider_azurerm_features_virtual_machine.graceful_shutdown
      skip_shutdown_and_force_delete = var.provider_azurerm_features_virtual_machine.skip_shutdown_and_force_delete
    }
    virtual_machine_scale_set {
      force_delete                  = var.provider_azurerm_features_virtual_machine_scale_set.force_delete
      roll_instances_when_required  = var.provider_azurerm_features_virtual_machine_scale_set.roll_instances_when_required
      scale_to_zero_before_deletion = var.provider_azurerm_features_virtual_machine_scale_set.scale_to_zero_before_deletion
    }
  }
}

provider "azurerm" {
  alias                      = "vhub"
  skip_provider_registration = true
  features {}
  subscription_id = local.connectivity_subscription_id
  tenant_id       = local.connectivity_tenant_id
}

data "azurerm_client_config" "current" {}


locals {

  # Update the tfstates map
  tfstates = merge(
    tomap(
      {
        (try(var.landingzone.key, var.landingzone[var.backend_type].key)) = local.backend[try(var.landingzone.backend_type, var.backend_type)]
      }
    )
    ,
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.tfstates, {})
  )


  backend = {
    azurerm = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
      key                  = var.tfstate_key
      level                = try(var.landingzone.level, var.landingzone[var.backend_type].level)
      tenant_id            = var.tenant_id
      subscription_id      = data.azurerm_client_config.current.subscription_id
    }
    remote = {
      hostname     = var.tf_cloud_hostname
      organization = var.tf_cloud_organization
      workspaces = {
        name = var.workspace
      }
    }
  }

}

