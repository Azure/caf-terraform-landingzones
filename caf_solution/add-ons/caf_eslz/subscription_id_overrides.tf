locals {
  subscription_id_overrides = {
    for key, value in var.subscription_id_overrides : key => compact(
      concat(
        value,
        [
          for mg_key, mg_value in try(var.subscription_id_overrides_by_keys[key], []) : local.caf.subscriptions[mg_value.lz_key][mg_value.key].subscription_id
        ]
      )
    )

  }
}
