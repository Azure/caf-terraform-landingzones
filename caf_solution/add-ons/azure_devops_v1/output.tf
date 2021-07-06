# output "keyvaults" {
#   value = tomap(
#     {
#       (var.landingzone.key) = module.caf.keyvaults
#     }
#   )
#   sensitive = true
# }

output "azure_devops" {
  value = var.azure_devops
}