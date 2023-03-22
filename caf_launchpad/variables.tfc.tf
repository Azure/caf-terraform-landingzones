variable "backend_type" {
  default     = "azurerm"
  description = "Set the terraform remote backend provider."
  validation {
    condition     = contains(["azurerm", "remote"], var.backend_type)
    error_message = "Only azurerm or remote are supported at that time."
  }
}
