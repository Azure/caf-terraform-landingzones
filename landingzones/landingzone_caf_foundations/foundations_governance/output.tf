#outputs the management group objects
output "management_groups" {
  value       = module.management_groups
  description = "management groups output"
}

# output "custom_policies" {
#   value       = module.custom_policies
#   description = "management groups output"
# }

# output "builtin_policies" {
#   value       = module.builtin_policies
#   description = "management groups output"
# }