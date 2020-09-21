# Variables of the landing zone launchpad

The launchpad landing zone leverage object variables to provide better understanding of the variables to set in the configuration files.

## launchpad_mode

There are two launchpad versions that can be deployed in an Azure subscription. When set to launchpad_light it not impersonating the rover to the launchpad aad application and keep the execution under the logged-in user. It is designed to provide a way to experience the landing zone when the logged-in user has limited privileges in the Azure AD tenant.

| Variable | Default | Allowed value | Type | Example |
|---|---|---|---|---|
| launchpad_mode | "launchpad_light" | ["launchpad_light", "launchpad"] | string | |

## level

| Variable | Description |
|---|---|
| level | The Cloud Adoption Framework for the Terraform Edition proposes to group landing zones into different levels to group per function and more importantly to secure the levels and prevent a level to access to an un-authorized level. More details on this link |


"level0" | ["level0", "level1", "level2", "level3", "level4"] | string | |

## global_settings

| Variable | Description |
|---|---|
| global_settings | The global_settings is an object containing the default settings the landing zones from a higher level can hinerit. |

| Default |
|---|
```hcl
default = {
  default_location  = "southeastasia"
  prefix            = null
}
```
### Attributes

| Attribute | Allowed values
|---|
* prefix is not set or null it generates a random 4 alpha char
* prefix = "" disable the prefix in the naming conventions
