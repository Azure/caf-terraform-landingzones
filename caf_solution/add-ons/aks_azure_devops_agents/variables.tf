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


variable "landingzone" {}
variable "rover_version" {
  default = null
}
variable "tags" {
  default = {}
}
variable "namespaces" {
  default = {}
}

variable "helm_charts" {
  default = {}
}
variable "aks_clusters" {}

variable "aks_cluster_key" {
}

variable "kustomization_overlays" {
  default = {}
}

variable "kustomization_builds" {
  default = {}
}

variable "agent_pools" {

}

variable "keyvaults" {
  default = {}
}

variable "managed_identities" {
  default = {}
}