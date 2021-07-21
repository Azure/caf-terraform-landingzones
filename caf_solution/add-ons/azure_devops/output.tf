output "keyvaults" {
  value = tomap(
    {
      (var.landingzone.key) = module.caf.keyvaults
    }
  )
  sensitive = true
}

# output "objects" {
#   value = tomap(
#     {
#       (var.landingzone.key) = {
#         for key, value in module.solution : key => value
#         if try(value, {}) != {}
#       }
#     }
#   )
#   sensitive = true
# }