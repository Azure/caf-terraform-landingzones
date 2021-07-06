# Map of the remote data state
variable "lower_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "lower_container_name" {
  description = "This value is propulated by the rover"
}
variable "lower_resource_group_name" {
  description = "This value is propulated by the rover"
}


variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
  default     = null
}
variable "tfstate_storage_account_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_container_name" {
  description = "This value is propulated by the rover"
}
variable "tfstate_resource_group_name" {
  description = "This value is propulated by the rover"
}
variable "sas_token" {
  default = null
}

variable "landingzone" {}
variable "virtual_hub_connections" {
  default = {}
}

variable "virtual_hub_subscription_id" {
  type        = string
  description = "Subscription ID of the Virtual Hub."
}

variable "virtual_hub_tenant_id" {
  type        = string
  description = "Tenant ID of the Virtual Hub."
}

variable "virtual_network_subscription_id" {
  type        = string
  description = "Subscription ID of the Virtual Network."
}

variable "virtual_network_tenant_id" {
  type        = string
  description = "Tenant ID of the Virtual Network."
}

variable "virtual_hub_lz_key" {
  type        = string
  description = "Virtual Hub landingzone key in var.landingzone.tfstate."
}
