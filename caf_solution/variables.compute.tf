variable "aks_clusters" {
  default = {}
}
variable "availability_sets" {
  default = {}
}
variable "azure_container_registries" {
  default = {}
}
variable "bastion_hosts" {
  default = {}
}
## Compute variables
variable "compute" {
  description = "Compute configuration objects"
  default = {
    # virtual_machines = {}
    # ...
  }
}
variable "container_groups" {
  default = {}
}
variable "proximity_placement_groups" {
  default = {}
}
variable "virtual_machines" {
  default = {}
}