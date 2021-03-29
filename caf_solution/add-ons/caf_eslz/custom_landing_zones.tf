locals {

  custom_landing_zones = {
    for lz_key, lz_value in var.custom_landing_zones : lz_key => {
      display_name               = lz_value.display_name
      parent_management_group_id = lz_value.parent_management_group_id
      subscription_ids           = lz_value.subscription_ids
      archetype_config           = lz_value.archetype_config
    }
  }

}