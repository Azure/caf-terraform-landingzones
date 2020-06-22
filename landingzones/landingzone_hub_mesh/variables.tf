# Map of the remote data state for lower level
variable "lowerlevel_storage_account_name" {}
variable "lowerlevel_container_name" {}
variable "lowerlevel_key" {} # Keeping the key for the lower level0 access
variable "lowerlevel_resource_group_name" {}
variable "workspace" {}


variable "tags" {
  type    = map
  default = {}
}

variable "virtual_hub_config" {
  description = "(Required) Configuration object for the hub"

}

variable "spokes" {
  description = "(Optional) Set of configuration objects for spoke virtual networks"
  # default     = {
  #   spoke1 = { "test"
  #     rg = {
  #       name = "test"
  #       location = "southeastasia"
  #     }
  #     peering_name = "test"
  #     network = {}
  #   }
  # }
  # type = list(object({
  #   rg = object(
  #     {name = string
  #     location = string}
  #   )
  #   peering_name = string
  #   network = object # networking object as defined in the Virtual Network module
  # })
  # )
}