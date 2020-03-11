# As per https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-09-01/azurefirewalls

resource "azurerm_template_deployment" "arm_template_vhub_firewall" {
    name                = var.name
    resource_group_name = var.rg
    # vwan_id             = var.vwan_id
    # location            = var.location

    template_body = file("${path.module}/arm_template_vhub_firewall.json")

    parameters = {
        "vwan_id"   = var.vwan_id,
        "name"      = var.name,
        "location"  = var.location,
        "Tier"      = "Standard",
    }

    deployment_mode = "Incremental"
}

## create the diagnostics
# module "diagnostics_vhub_firewall" {
#   source  = "aztfmod/caf-diagnostics/azurerm"
#   version = "1.0.0"

#     name                            = "${var.name}-diags"
#     resource_id                     = azurerm_template_deployment.arm_template_vhub_firewall.outputs.resourceID
#     log_analytics_workspace_id      = var.log_analytics_workspace_id
#     diagnostics_map                 = var.diagnostics_map
#     diag_object                     = var.bastion_config.diagnostics_settings
# }
