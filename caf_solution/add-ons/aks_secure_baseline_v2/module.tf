module "flux" {
  source   = "./flux"
  for_each = var.flux_settings
  setting  = each.value
}
