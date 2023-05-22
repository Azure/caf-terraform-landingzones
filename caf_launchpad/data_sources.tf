module "data_sources" {
  source = "../data_sources"
  for_each = can(var.data_sources) ? toset(["data"]) : []

  data_sources = var.data_sources
}

locals {
  data_sources = module.data_sources
}
