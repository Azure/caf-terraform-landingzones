output "blueprint_foundations_accounting" {
  depends_on  = [module.blueprint_foundations_accounting]

  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_foundations_accounting
  description = "Full output of the foundations logging blueprint"
}

output "blueprint_foundations_security" {
  depends_on  = [module.blueprint_foundations_security]

  sensitive   = true                      # to hide content from logs
  value       = module.blueprint_foundations_security
  description = "Full output of the foundations logging blueprint"
}

output "blueprint_foundations_governance" {
  depends_on  = [module.blueprint_foundations_governance]

  sensitive   = false                      # to hide content from logs
  value       = module.blueprint_foundations_governance
  description = "Full output of the foundations logging blueprint"
}

output "prefix" {
  value = local.prefix
  description = "prefix from level0"
}

# output "tags" {
#   value = var.global_settings.tags_hub
#   description = "default tags for the objects in foundations blueprint"
# }

output "global_settings" {
  value = var.global_settings
  description = "global settings of the landing zone"
}