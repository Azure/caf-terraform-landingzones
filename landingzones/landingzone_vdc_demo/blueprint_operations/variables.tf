
variable "asr_config" {
  description = "config for the Azure Site Recovery Vault"
}

variable "asr_rg" {
  description ="Name for RG of Azure Site Recovery Vault"
}

variable "auto_config" {
  description = "config for the automation account"
}

variable "auto_rg" {
  description ="Name for RG of the automation account"
}

variable "location" {
  description = "Azure region to deploy the resources."
}

variable "resource_groups_operations" {
  description = "(Required) resource group for operations"
}

variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"    
}

variable "global_settings" {
  description = "global settings"
}

variable "caf_foundations_accounting" {
  description = "caf_foundations_accounting settings"
}