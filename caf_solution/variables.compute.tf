variable "aks_clusters" {
  default = {}
}
variable "aro_clusters" {
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
variable "batch_accounts" {
  default = {}
}
variable "batch_applications" {
  default = {}
}
variable "batch_certificates" {
  default = {}
}
variable "batch_jobs" {
  default = {}
}
variable "batch_pools" {
  default = {}
}
variable "container_app_environments" {
  default = {}
}
variable "container_app_environment_certificates" {
  default = {}
}
variable "container_app_dapr_components" {
  default = {}
}
variable "container_apps" {
  default = {}
}
variable "container_app_environment_storages" {
  default = {}
}
variable "container_groups" {
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
variable "dedicated_host_groups" {
  default = {}
}
variable "dedicated_hosts" {
  default = {}
}
variable "machine_learning_compute_instance" {
  default = {}
}
variable "proximity_placement_groups" {
  default = {}
}
variable "runbooks" {
  default = {}
}
variable "virtual_machine_scale_sets" {
  default = {}
}
variable "virtual_machines" {
  default = {}
}
variable "vmware_clusters" {
  default = {}
}
variable "vmware_express_route_authorizations" {
  default = {}
}
variable "vmware_private_clouds" {
  default = {}
}
variable "wvd_application_groups" {
  default = {}
}
variable "wvd_applications" {
  default = {}
}
variable "wvd_host_pools" {
  default = {}
}
variable "wvd_workspaces" {
  default = {}
}