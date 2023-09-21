output "objects" {
  value = tomap(
    {
      (var.landingzone.key) = {
        for key, value in module.caf : key => value
        if try(value, {}) != {}
      }
    }
  )
  sensitive = true
}

output "tfstates" {
  value     = local.tfstates
  sensitive = true
}
