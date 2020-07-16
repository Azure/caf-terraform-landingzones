output "foundations_accounting" {
  depends_on = [module.foundations_accounting]

  sensitive   = true # to hide content from logs
  value       = module.foundations_accounting
  description = "Full output of the foundations logging addon"
}

output "foundations_security" {
  depends_on = [module.foundations_security]

  sensitive   = true # to hide content from logs
  value       = module.foundations_security
  description = "Full output of the foundations logging addon"
}

output "foundations_governance" {
  depends_on = [module.foundations_governance]

  sensitive   = false # to hide content from logs
  value       = module.foundations_governance
  description = "Full output of the foundations logging addon"
}

output "prefix" {
  value       = local.prefix
  description = "prefix from level0"
}

output "environment" {
  value       = local.environment
  description = "environment from level0"
}


# output "tags" {
#   value = var.global_settings.tags_hub
#   description = "default tags for the objects in foundations addon"
# }

output "global_settings" {
  value       = merge(var.global_settings, local.global_settings)
  description = "global settings of the landing zone"
}