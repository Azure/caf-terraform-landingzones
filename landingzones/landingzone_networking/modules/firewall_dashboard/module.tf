resource "azurerm_dashboard" "egress_dashboard" {
  name                = var.name
  resource_group_name = var.rg
  location            = var.location
  tags                = var.tags

  dashboard_properties = templatefile("${path.module}/egress-dashboard.tpl",
    {
      md_content = "CAF landing zones - Egress Dashboard"

      pip_id = var.pip_id
      fw_id  = var.fw_id
  })
}

