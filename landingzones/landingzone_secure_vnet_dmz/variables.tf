# Map of the remote data state
variable "lowerlevel_storage_account_name" {}
variable "lowerlevel_container_name" {}
variable "lowerlevel_key" {}                  # Keeping the key for the lower level0 access
variable "lowerlevel_resource_group_name" {}
variable "tags" {
    type = map
    default = {}
}
variable "prefix" {
  description = "(Optional) Prefix to uniquely identify the deployment"
  default = ""
}
variable "workspace" {}
variable "logged_user_objectId" {}