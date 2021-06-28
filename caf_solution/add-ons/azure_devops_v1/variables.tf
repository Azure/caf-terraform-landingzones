# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}

variable "tfstate_subscription_id" {
  description = "This value is propulated by the rover. subscription id hosting the remote tfstates"
}

variable "global_settings" {
  default = {}
}
variable "tenant_id" {}
variable "landingzone" {
}
variable "rover_version" {
  default = null
}

variable "logged_user_objectId" {
  default = null
}
variable "logged_aad_app_objectId" {
  default = null
}
variable "azure_devops" {
  default = {}
}
variable "tags" {
  type        = map(any)
  default     = null
}
variable "organization_agent_pools" {
  default = {}
}
variable "organization_url" {}
variable "projects" {
  default = {}
}
variable "project_agent_pools" {
  default = {}
}
variable "service_endpoints" {
  default = {}
}
variable "variable_groups" {
  default = {}
}
variable "pipelines" {
  default = {}
}
variable "azdo_admin_pat" {
  type        = string
  default     = null
  description = "(Optional). Azure Devops PAT Token. If not provided with this value must be retrieved from the Keyvault secret."
}
