# Map of the remote data state
variable "lowerlevel_storage_account_name" {}
variable "lowerlevel_container_name" {}
variable "lowerlevel_key" {}                  # Keeping the key for the lower level0 access
variable "lowerlevel_resource_group_name" {}

variable "global_settings" {}
variable "accounting_settings" {}
variable "security_settings" {}
variable "governance_settings" {}