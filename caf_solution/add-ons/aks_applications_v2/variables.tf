# Map of the remote data state for lower level
variable "lower_storage_account_name" {}
variable "lower_container_name" {}
variable "lower_resource_group_name" {}

variable "tfstate_subscription_id" {
  description = "This value is populated by the rover. subscription id hosting the remote tfstates"
}
variable "tfstate_storage_account_name" {}
variable "tfstate_container_name" {}
variable "tfstate_key" {}
variable "tfstate_resource_group_name" {}
variable "global_settings" {
  default = {}
}
variable "settings" {
  default = {}
}
variable "landingzone" {}
variable "rover_version" {
  default = null
}
variable "namespaces" {
  default = {}
}
variable "helm_charts" {
  default = {}
}
variable "aks_clusters" {
  default = {}
}
variable "role" {
  default = {}
}
variable "cluster_role" {
  default = {}
}
variable "role_binding" {
  default = {}
}
variable "cluster_role_binding" {
  default = {}
}
variable "keyvaults" {}
variable "kv_csi_driver" {
  default = {}
}
variable "secret_identity_id" {
  default = null
}
variable "manifests" {
  default = {}
}