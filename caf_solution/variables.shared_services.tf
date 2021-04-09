# Shared services
variable "shared_services" {
  description = "Shared services configuration objects"
  default = {
    # automations = {}
    # monitoring = {}
    # recovery_vaults = {}
  }
}

variable "automations" {
  default = {}
}

variable "image_definitions" {
  default = {}
}

variable "monitoring" {
  default = {}
}

variable "packer_service_principal" {
  default = {}
}

variable "packer_managed_identity" {
  default = {}
}

variable "recovery_vaults" {
  default = {}
}

variable "shared_image_galleries" {
  default = {}
}