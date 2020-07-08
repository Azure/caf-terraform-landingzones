variable "vm_object" {}
variable "azure_devops" {}

variable "use_prefix" {
    default = true
    type = bool
}

variable "convention" {
    description = "(Optional) (Default = cafrandom) Naming convention to apply to the resources at creating time"
    default = "cafrandom"
}

variable "location" {
  type = string
  default = "westus2"
}


variable "azure_devops_pat_token" {}

variable "acr_object" {}