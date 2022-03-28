# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

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
variable "databricks_clusters" {
  description = "This resource allows you to create, update, and delete clusters."
  default     = {}
}
variable "databricks_workspace" {
  description = "Azure Databricks workspace where the resources will be created"
}