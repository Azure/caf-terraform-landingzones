variable "policies_matrix" {
  description = "Matrix of settings that will be applied to the configuration container - typically management group"
}

variable "scope" {
  description = "The scope  where the policies will be assigned"
}

variable "log_analytics" {
  description = "Log analytics repository"
}
