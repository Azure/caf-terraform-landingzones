#Terraform AzureRM CAF uses local.search_services.search_services in search_service.tf, need to use locals.
locals {
  search_services = merge(
    var.search_services,
    {
      search_services = var.search_services
    }
  )
}