# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_resource_group_name" {}
# variable tfstate_key {}

variable "global_settings" {
  default = {}
}

# variable tenant_id {}
variable "landingzone" {}

variable "namespaces" {}

variable "tags" {
  default = null
  type    = map(any)
}

variable "helm_charts" {}

variable "rover_version" {
  default = null
}

variable "cluster_re1_key" {
  default = null
}
variable "cluster_re2_key" {
  default = null
}