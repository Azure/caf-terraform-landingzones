# Module development guidelines

This document summarizes our coding practices for modules, they are liberally based on https://www.terraform.io/docs/modules/index.html.

All modules must be stored inside a different repository, since module will be published on the Terraform Registry they must use the naming convention as described [here](https://www.terraform.io/docs/registry/modules/publish.html).

## Process to contribute

Module contribution workflow:

1. Before submitting a pull request (PR), please open an issue describing your changes in details and the reasons for the change with an example.
1. On submitting the PR, please refer to the checklist.

Checklist for module PR review:

1. Coding conventions described below.
2. Provide example including the main scenario the module is supposed to achieve.
3. Use naming convention.
4. Follow the common engineering criteria.
5. Include code validation hooks.
6. Include unit and integration testing.

## Modules structure convention

### Root file structure

The main module directory will contain at least the following files:

| Filename       | Content                                                                                                                                                                                                  |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| main.tf        | Contains the entry point data, data sources, etc.                                                                                                                                                        |
| module.tf      | Contains the main coding for the module logic.                                                                                                                                                           |
| variables.tf   | Contains the input variables.                                                                                                                                                                            |
| diagnostics.tf | Contains the call to the diagnostics and operations logs features for the resources created in the module. This will be called via the external diagnostics module using the arguments passed in tfvars. |
| versions.tf    | Terraform modules versions constraints if any. Avoid as possible to put version constraints in module and try to manage that in the blueprints.                                                          |
| output.tf      | Output variables to export.                                                                                                                                                                              |
| README.MD      | Short description of the features the module is achieving, the input and output variables.                                                                                                               |
| CHANGELOG.MD   | Version history, new features, improvements and bugs with version number aligned with GitHub releases.                                                                                                   |

### Mandatory examples

Each module must have at least an example that must be easy to trigger, you shall use the following structure for examples:
| Filename   | Content                                                                                                                    |
|------------|----------------------------------------------------------------------------------------------------------------------------|
| README.MD  | Short description of the example, the input and output variables.                                                          |
| locals.tf  | Contains the local variable that are necessary to make the module example working.                                         |
| outputs.tf | Output variables to export.                                                                                                |
| test.tf    | Contains the logic of the test that will call the module locally and will include dependencies to make the example working |

In examples, you must use *caf_random* or *random* naming convention in order to avoid naming collisions.

### Module Output conventions

As a convention we will use the following minimal module outputs:

| Output variable name | Content                          |
|----------------------|----------------------------------|
| id                   | returns the object identifiers   |
| name                 | returns the object name          |
| object               | returns the full resource object |

Any other resource specific outputs.

## Common engineering criteria

### CEC1: Naming convention provider

Every resource created must use the naming convention provider as published here: https://github.com/aztfmod/terraform-provider-azurecaf

If you are developing a module for which there is no current support for naming convention method, please submit an issue: https://github.com/aztfmod/terraform-provider-azurecaf/issues

Example of naming convention provider usage to create a virtual network:
```hcl
resource "azurecaf_naming_convention" "caf_name_vnet" {
  name          = var.networking_object.vnet.name
  prefix        = var.prefix != "" ? var.prefix : null
  postfix       = var.postfix != "" ? var.postfix : null
  max_length    = var.max_length != "" ? var.max_length : null
  resource_type = "azurerm_virtual_network"
  convention    = var.convention
}
```

At the resource creation, you use the ```result``` output of the ```azurecaf_naming_convention``` provider:

```hcl
resource "azurerm_virtual_network" "vnet" {
  name                = azurecaf_naming_convention.caf_name_vnet.result
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.networking_object.vnet.address_space
  tags
```

In order to support naming convention, the following variables are leveraged for each module:

```hcl
variable "convention" {
  description = "(Required) Naming convention method to use"
}

variable "prefix" {
  description = "(Optional) You can use a prefix to the name of the resource"
  type        = string
  default     = ""
}

variable "postfix" {
  description = "(Optional) You can use a postfix to the name of the resource"
  type        = string
  default     = ""
}

variable "max_length" {
  description = "(Optional) You can specify a maximum length to the name of the resource"
  type        = string
  default     = "60"
}
```

### CEC2: Mandate usage of diagnostics for all components deployed

#### Log repositories

All resources deployed within a module must have diagnostics logging enabled, those diagnostics capabilities are not the module responsibilities and must be implemented outside via the appropriate fundamental modules:

1. [Diagnostics logging](https://github.com/aztfmod/terraform-azurerm-caf-log-analytics)
2. [Log Analytics](https://github.com/aztfmod/terraform-azurerm-caf-diagnostics-logging)

Please refer to the two modules documentation for the output format.
For each module deploying resources with diagnostics capabilities, the output of those two modules will be mandatory input variables as follow:

```hcl
variable "diagnostics_map" {
  description = "(Required) contains the SA and EH details for operations diagnostics"
}

variable "log_analytics_workspace" {
  description = "(Required) contains the log analytics workspace details for operations diagnostics"
}
```

#### Log parameters

To enable diagnostics for a module, you must use input variable ```diagnostics_settings``` as follows:

```hcl
variable "diagnostics_settings" {
  description = "(Required) configuration object describing the diagnostics"
}
```

A diagnostic_settings object is structured as follow:

```hcl
diagnostics_settings = {
    log = [
           ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
                ["AzureBackupReport", true, true, 20],
        ]
    metric = [
               #["AllMetrics", 60, True],
    ]
}
```

For readability we don't generally recommend too deep module nesting, but in order to abstract the setting of the diagnostics with the diagnostic structure described above, you can leverage the: [Diagnostics settings module](https://github.com/aztfmod/terraform-azurerm-caf-diagnostics) for Cloud Adoption Framework for Azure landing zones:

### CEC3: Avoid count iterators

In order to allow reliable iterations within the modules, we recommend using ```for_each``` iteration and decomission usage of count for iterations as much as possible.

```hcl
resource "azurerm_log_analytics_solution" "la_solution" {
  for_each = var.solution_plan_map

    solution_name         = each.key
    location              = var.location
    resource_group_name   = var.resource_group_name
    workspace_resource_id = azurerm_log_analytics_workspace.log_analytics.id
    workspace_name        = azurerm_log_analytics_workspace.log_analytics.name

  plan {
    product   = each.value.product
    publisher = each.value.publisher
  }
}
```

This will allow:

1. More reliable lifecycles for resources your create iteratively.
2. Using ```key`` that can be leveraged in other modules or resources iterations.
3. Better visibility in the log files.

### CEC4: Unity of deployment

Starting on Terraform 0.13, modules shall not internally iterate on complex structures and this shall the done by the calling landing zone using ```for_each``` capabilities. This shall be slowly adapted and refactored and shall be revised depending on our findings.

### CEC5: Variables custom validation

Starting in Terraform 0.13, you can leverage custom variables validation. As documented [here](https://www.terraform.io/docs/configuration/variables.html) we recommend roll-out of this feature in module, alongside with default variables values including in complex objects.

Example: Custom validation
```hcl
variable convention {
  description = "(Required) Naming convention to use"
  type        = string
  default     = "cafrandom"

  validation {
    condition     = contains(["cafrandom", "random", "passthrough", "cafclassic"], var.convention)
    error_message = "Allowed values are cafrandom, random, passthrough or cafclassic."
  }
}
```

Example: Complex objects defaults:
```hcl
variable keyvaults {
  description = "(Required) Key Vault objects to create"
  default = {
    launchpad = {
      name                = "launchpad"
      resource_group_name = "caf-foundations"
      region              = "southeastasia"
      convention          = "cafrandom"
      sku_name            = "standard"
    }
  }
}
```

## Tooling

Modules must be developed using rover version > 2006.x as it comes with required tools:

* pre-commit: adds Git hooks before commits.
* tfsec: security static code analysis.
* tflint: linting for Terraform code.
* terraform_docs: automated generation of documentation.

Pre-commit minimum set of checks:

```yaml
     - id: terraform_fmt
     - id: terraform_docs
     - id: terraform_tflint
     - id: terraform_tfsec
```

## Unit and integration testing

Each module must implement integration and unit testing using GitHub Actions following the example here: https://github.com/aztfmod/terraform-azurerm-caf-resource-group

Please refer to the unit and integration testing reference article: https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/test/unit_test.md

### GitHub Actions for Testing

New modules must implement the automation of integration testing using GitHub actions and deploying the examples in an Azure test subscription.
This testing must also include static security analysis as https://github.com/triat/terraform-security-scan

[Back to summary](../README.md)