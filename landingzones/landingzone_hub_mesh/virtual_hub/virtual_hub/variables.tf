variable "location" {
  description = "(Required) region to deploy the resource" 
}

variable "rg" {
  description = "(Required) resource group name"
}

variable "vwan" {
  description = "(Required) Configuration object for virtual wan"
}

variable "tags" {
  description = "(Required) Tags"
}

variable "vwan_id" {}
