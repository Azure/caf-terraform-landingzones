variable "namespaces_v1" {
  default = {}
}

variable "managed_identities" {
  default = {}
}

variable "settings" {
  default = {}
}

variable "resource_groups" {
  default = {}
}

variable "oidc_issuer_url" {
  default = null
}

variable "azuread_applications" {
  default = {}
}

variable "aks_cluster_rg_name" {
  default = null
}