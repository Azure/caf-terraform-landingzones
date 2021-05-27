
output "objects" {
  value = tomap(
    { (var.landingzone.key) = {
      for key, value in module.launchpad : key => value
      if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "global_settings" {
  value = module.launchpad.global_settings
  sensitive = true
}

output "diagnostics" {
  value = module.launchpad.diagnostics
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}
