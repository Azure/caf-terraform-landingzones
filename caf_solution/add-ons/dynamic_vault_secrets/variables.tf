# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}
variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}

variable "global_settings" {
  default = {}
}

variable "landingzone" {
  default = ""
}

variable "environment" {
  default = ""
}

variable "rover_version" {
  default = null
}
variable "tags" {
  default = null
  type    = map(any)
}
variable "dynamic_vault_secrets" {}