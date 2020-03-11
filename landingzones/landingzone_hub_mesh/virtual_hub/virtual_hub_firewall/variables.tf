variable "rg" {
  type        = string
  description = "Resource group of the deployment"
}

variable "location" {
  type        = string
  description = "Location of the deployment"
}

variable "tags" {
  description = "Tags"
}

variable "vwan_id" {
  type        = string
  description = "Virtual WAN object ID"
}

variable "name" {
    type = string
    description = "name of the firewall for vhub"
}