
# Upgrade from 2203.0

caf_launchpad will perform the following changes when upgrading from ***2203.0***. Before applying, review the following changes and adjust the values before deploying them. Note some resources will be destroyed and replaced by newer resources. This readme details those changes.

You can compare the caf_launchpad/scenario/200/*.tfvars between versions 2203.0 and 5.7.2 to identify the changes to perform in your launchpad.

As always, open issues if you need some help.

## Guidance

- Updgrade the rover to a version 1.3.9, 1.4.9 or 1.5.3 (latested recommended)
- Updgrade your pipelines with the landingzone tag ***5.7.2***

WARNING: Make sure you are not using a branch but the tag value ***5.7.2***

## Breaking changes

### Removing level3 and level4 from the launchpad as it is now moved to the ASVM pattern

Check templates/asvm for an example.

### Removing the azuread_users

It was included more for demonstration purposes.

```hcl
# module.launchpad.module.azuread_users["aad-user-devops-user-admin"].azuread_user.account will be destroyed
# (because module.launchpad.module.azuread_users["aad-user-devops-user-admin"] is not in configuration)
```

## Upgrades

### Keyvault authentication with Azure AD Authentication

Removing the keyvault access policies and moving them to role_mapping

```hcl
# module.launchpad.module.keyvault_access_policies["level0"].module.azuread_group["keyvault_level0_rw"].azurerm_key_vault_access_policy.policy will be destroyed
# (because module.launchpad.module.keyvault_access_policies["level0"].module.azuread_group["keyvault_level0_rw"] is not in configuration)
```

## Updating rover caf tags to locate the launchpad (backend storage accounts for tfstates)

- Moving from environment to caf_environment (To release the tag environment used by customers for a different purpuse). caf_environment is used by the rover to locate the storage account used by terraform azurerm backend

- Moving from level to caf_tfstate. caf_tfstate is used by the rover to locate the current and lower level storage accounts for terraform azurerm backend

```hcl
~ tags                                = {
    "BusinessUnit"    = "SHARED"
    "DR"              = "NON-DR-ENABLED"
  + "caf_environment" = "2203"
  + "caf_tfstate"     = "level0"
    "costCenter"      = "0"
    "deploymentType"  = "Terraform"
  - "environment"     = "2203" -> null
    "landingzone"     = "launchpad"
  - "level"           = "level0" -> null
  - "module"          = "namespaces" -> null
    "owner"           = "CAF"
    "rover_version"   = "aztfmod/rover:1.4.6-2306.1405"
}
```

### Moving from azuread_apps to azuread_applications and azuread_service_principals

azuread_apps was combining a too much opiniated approach that was combining the creation of an azuread_application and an azuread_service_princial. The password were set at the service principal level, preventing some of the cross-tenant scenarios.

It is now decoupled into two standalone top resources azuread_applications and azuread_service_principals.

From
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].azuread_application.app will be destroyed
# (because module.launchpad.module.azuread_applications["caf_launchpad_level0"] is not in configuration)
```
and
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].azuread_service_principal.app will be destroyed
  # (because module.launchpad.module.azuread_applications["caf_launchpad_level0"] is not in configuration)
```

To
```hcl
# module.launchpad.module.azuread_applications_v1["caf_launchpad_level0"].azuread_application.app will be created
```

### Upgraded version of the azuread provider

Moving from Active Directory API to Microsoft Graph API
It is not possible anymore to set a password to an azuread application. Therefore the previous created passwords are now removed.

***client_id*** and ***client_secrets*** are recreated. Note after the apply the secret will be stored into the keyvault's secret as before.

It should not impact your azure devops pipelines if using variables group to keyvault to inject them at runtime. If you are not using this pattern you will have to update your devops secrets those values.

To
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].azuread_service_principal_password.pwd will be destroyed
# (because module.launchpad.module.azuread_applications["caf_launchpad_level0"] is not in configuration)
```
and
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].azurerm_key_vault_secret.client_id["level0"] will be destroyed
# (because module.launchpad.module.azuread_applications["caf_launchpad_level0"] is not in configuration)
```
and (password's stored in keyvault's secret)
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].azurerm_key_vault_secret.client_secret["level0"] will be destroyed
# (because module.launchpad.module.azuread_applications["caf_launchpad_level0"] is not in configuration)
```
and (passwork rotation)
```hcl
# module.launchpad.module.azuread_applications["caf_launchpad_level0"].random_password.pwd will be destroyed
# (because random_password.pwd is not in configuration)
```
and (azuread roles)
```hcl
# module.launchpad.module.azuread_roles_applications["caf_launchpad_level0"].null_resource.set_azure_ad_roles["Application Administrator"] will be destroyed
# (because module.launchpad.module.azuread_roles_applications["caf_launchpad_level0"] is not in configuration)
```

## Role assignments are upadated

To reflect the move from azuread_apps to azuread_applications and azured_service_principals, roles are re-mapped to the new service principal.

From
```hcl
# module.launchpad.azurerm_role_assignment.for["azuread_apps_logged_in_subscription_caf-launchpad-contributor_caf_launchpad_level0"] will be destroyed
```
and
```hcl
# module.launchpad.module.azuread_roles_applications["caf_launchpad_level0"].null_resource.set_azure_ad_roles["Application Developer"] will be destroyed
# (because module.launchpad.module.azuread_roles_applications["caf_launchpad_level0"] is not in configuration)
```

To
```hcl
# module.launchpad.module.azuread_roles_service_principals["caf_launchpad_level0"].null_resource.set_azure_ad_roles["Application Developer"] will be created
```
and
```hcl
# module.launchpad.azurerm_role_assignment.for["azuread_service_principals_logged_in_subscription_Contributor_caf_launchpad_level0"] will be created
```

