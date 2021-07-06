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

variable "landingzone" {}
variable "rover_version" {
  default = null
}
variable "tags" {
  default = {}
}

######

variable "aks_cluster_key" {
  description = "AKS cluster key to deploy the Gitlab Helm charts. The key must be defined in the variable aks_clusters"
}
variable "aks_cluster_vnet_key" {

}
variable "aks_clusters" {}
variable "vnets" {}
variable "managed_identities" {
  description = "Map of the user managed identities."
}

variable "aad_pod_identity" {}
variable "keyvaults" {
  default = {}
}