# data "terraform_remote_state" "current_networking" {
#   for_each = try(var.landingzone.current.networking, {})

#   backend = var.landingzone.backend_type
#   config = {
#     storage_account_name = var.tfstate_storage_account_name
#     container_name       = var.tfstate_container_name
#     resource_group_name  = var.tfstate_resource_group_name
#     key                  = each.value.tfstate
#   }
# }

locals {
  # Merge all remote networking objects
  # lower_networking = {
  #   for key, networking in try(var.landingzone.current.networking, {}) : key => merge(data.terraform_remote_state.current_networking[key].outputs.networking[key])
  # }

  # Combine them with the local networking objects

}