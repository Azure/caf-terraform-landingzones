variable "location" {
  description = "(Required) Define the region to be protected by DDoS protection"
}

variable "rg" {
  description = "(Required) Define the resource group name where to deploy DDoS protection"
}

variable "name" {
  description = "(Required) Name of DDoS protection"
}

variable "enable_ddos_standard" {
  description = "(Required) Switch to enable DDoS protection standard"
}

variable "tags" {
  description = "(Required) Tags of DDoS protection"
}