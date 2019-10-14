
variable "asr_vault_name" {
  description ="Name for the Azure Site Recovery Vault"
}

variable "asr_rg" {
  description ="Name for RG of Azure Site Recovery Vault"
}

variable "auto_account" {
  description ="Name for the automation account"
}

variable "auto_rg" {
  description ="Name for RG of the automation account"
}

variable "log_analytics_workspace" {
  description = "map structure with the list of log analytics data"  
}

variable "diagnostics_map" {
  description = "Structure that contains the diagnostics data."
}

variable "location" {
  description = "Azure region to deploy the resources."
}

variable "tags" {
  description = "map of the tags to be applied."
}

variable "asr_diags" {
  description = "(Required) Structure for the diagnostics to be deployed for ASR."
}

variable "auto_diags" {
  description = "(Required) Structure for the diagnostics to be deployed for automation account."
}

variable "resource_groups_operations" {
  description = "(Required) resource group for operations"
}

variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"    
}