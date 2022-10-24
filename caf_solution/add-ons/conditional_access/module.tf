module "conditional_access" {
#  depends_on = [module.caf]
  source = "git::https://github.com/VolkerWessels/terraform-conditional-access.git?ref=main"

  library_path = var.library_path
  template_file_variables = var.template_file_variables
  named_locations = var.named_locations
}