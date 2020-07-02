locals {

  api_permissions_for_sp = flatten(
    [
      for key, app in var.aad_api_permissions : [
        for resources in app : [
          for resource in resources.resource_access : {
            aad_app_key     = key
            resource_app_id = resources.resource_app_id
            id              = resource.id
            type            = resource.type
          } if resource.type == "Role"
        ]
      ]
    ]
  )

  api_permissions_for_user = distinct(
    flatten(
      [
        for key, app in var.aad_api_permissions : [
          for resources in app : [
            for resource in resources.resource_access : {
              aad_app_key = key
            }
          ]
        ]
      ]
    )
  )

  ### Fltattening the list to only the applications when granting concent with a logged-in user type user
  # value = [
  #   {"aad_app_key" = "aztfmod_level0" },
  #   {"aad_app_key" = "azure_caf-terraform-landingzones"},
  # ]

  api_permissions = var.user_type == "user" ? local.api_permissions_for_user : local.api_permissions_for_sp

}


resource "null_resource" "grant_admin_consent" {
  depends_on = [module.azure_applications]

  for_each = {
    for key, permission in local.api_permissions : key => permission
  }

  provisioner "local-exec" {
    command     = "./scripts/grant_consent.sh"
    interpreter = ["/bin/sh"]
    on_failure  = fail

    environment = {
      resourceAppId = var.user_type == "user" ? null : each.value.resource_app_id
      appRoleId     = var.user_type == "user" ? null : each.value.id
      principalId   = var.user_type == "user" ? null : module.azure_applications.aad_apps[each.value.aad_app_key].azuread_service_principal.id
      applicationId = module.azure_applications.aad_apps[each.value.aad_app_key].azuread_application.application_id
    }
  }
}
