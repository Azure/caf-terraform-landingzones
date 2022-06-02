variable "provider_azurerm_features_api_management" {
  default = {
    purge_soft_delete_on_destroy         = true
    recover_soft_deleted_api_managements = true
  }
}

variable "provider_azurerm_features_application_insights" {
  default = {
    disable_generated_rule = false
  }
}

variable "provider_azurerm_features_cognitive_account" {
  default = {
    purge_soft_delete_on_destroy = true
  }
}

variable "provider_azurerm_features_keyvault" {
  default = {
    purge_soft_delete_on_destroy               = false
    purge_soft_deleted_certificates_on_destroy = false
    purge_soft_deleted_keys_on_destroy         = false
    purge_soft_deleted_secrets_on_destroy      = false
    recover_soft_deleted_certificates          = true
    recover_soft_deleted_key_vaults            = true
    recover_soft_deleted_keys                  = true
    recover_soft_deleted_secrets               = true
  }
}

variable "provider_azurerm_features_log_analytics_workspace" {
  default = {
    permanently_delete_on_destroy = true
  }
}

variable "provider_azurerm_features_resource_group" {
  default = {
    prevent_deletion_if_contains_resources = false
  }
}

variable "provider_azurerm_features_template_deployment" {
  default = {
    delete_nested_items_during_deletion = false
  }
}

variable "provider_azurerm_features_virtual_machine" {
  default = {
    delete_os_disk_on_deletion     = true
    graceful_shutdown              = false
    skip_shutdown_and_force_delete = false
  }
}

variable "provider_azurerm_features_virtual_machine_scale_set" {
  default = {
    force_delete                  = false
    roll_instances_when_required  = true
    scale_to_zero_before_deletion = true
  }
}