module "application_gateway" {
  source              = "../.."

  resource_group_name  = "rg_neu_terraform"
  location            = "northeurope"

  appgw_object        = var.appgw_object
  app_object          = var.app_object 
}