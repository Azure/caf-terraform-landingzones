output "objects" {
  value     = module.enterprise_scale
  sensitive = true
}

output "custom_landing_zones" {
  value = local.custom_landing_zones
}