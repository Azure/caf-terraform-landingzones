resource "null_resource" "wait_for_virtual_hub_state" {
  for_each = var.virtual_hub_connections

  triggers = {
    routing = try(jsonencode(each.value.routing), null)
  }

  provisioner "local-exec" {
    command = format("%s/scripts/wait.sh", path.module)

    environment = {
      VIRTUAL_HUB_ID = try(data.terraform_remote_state.remote[each.value.virtual_hub.lz_key].outputs.objects[each.value.virtual_hub.lz_key].virtual_hubs[each.value.virtual_hub.key].id,
      data.terraform_remote_state.remote[each.value.virtual_hub.lz_key].outputs.objects[each.value.virtual_hub.lz_key].virtual_wans[each.value.virtual_hub.vwan_key].virtual_hubs[each.value.virtual_hub.key].id)
    }
  }
}

resource "azurerm_virtual_hub_connection" "conn" {
  for_each   = var.virtual_hub_connections
  depends_on = [null_resource.wait_for_virtual_hub_state]

  name = each.value.name
  virtual_hub_id = try(data.terraform_remote_state.remote[each.value.virtual_hub.lz_key].outputs.objects[each.value.virtual_hub.lz_key].virtual_hubs[each.value.virtual_hub.key].id,
  data.terraform_remote_state.remote[each.value.virtual_hub.lz_key].outputs.objects[each.value.virtual_hub.lz_key].virtual_wans[each.value.virtual_hub.vwan_key].virtual_hubs[each.value.virtual_hub.key].id)
  remote_virtual_network_id = try(
    each.value.vnet.id,
    data.terraform_remote_state.remote[each.value.vnet.lz_key].outputs.objects[each.value.vnet.lz_key].vnets[each.value.vnet.vnet_key].id
  )
  internet_security_enabled = try(each.value.internet_security_enabled, false)

  dynamic "routing" {
    for_each = try(each.value.routing, null) == null ? [] : [1]

    content {

      associated_route_table_id = data.terraform_remote_state.remote[each.value.routing.virtual_hub_route_table.lz_key].outputs.objects[each.value.routing.virtual_hub_route_table.lz_key].virtual_hub_route_table[each.value.routing.virtual_hub_route_table.key].id

      dynamic "propagated_route_table" {
        for_each = try(each.value.routing.propagated_route_table, null) == null ? [] : [1]

        content {
          route_table_ids = flatten(
            [
              [
                try(each.value.routing.propagated_route_table.ids, []),
              ],
              [
                for key, value in try(each.value.routing.propagated_route_table.route_tables, []) :
                [
                  data.terraform_remote_state.remote[value.lz_key].outputs.objects[value.lz_key].virtual_hub_route_table[value.key].id
                ]
              ]
            ]
          )
          labels = try(each.value.routing.propagated_route_table.labels, null)
        }
      }
    }
  }

  provider = azurerm.virtual_hub
}

output "azurerm_virtual_hub_connection" {
  value = azurerm_virtual_hub_connection.conn
}
