locals {
  module_tag          = {
    "blueprint" = basename(abspath(path.module))
  }
  tags                = merge(var.tags, local.module_tag)
}