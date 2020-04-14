# Conventions for module creation

All modules shall be stored inside a different repository, and must use the convention as described [here](https://www.terraform.io/docs/registry/modules/publish.html).Module must use semantic versioning.

## Structure for the module directory

| Filename| Content  |
|--|--|
| main.tf  |  Contains the entry point data, data sources, etc.|
| module.tf | Contains the main coding for the module logic. |
| variables.tf | Contains the input variables.|
| diagnostics.tf | Contains the call to the diagnostics and operations logs features for the resources created in the module. This will be called via the external diagnostics module using the arguments passed in tfvars.   |
| versions.tf | Terraform modules versions constraints if any. Avoid as possible to put version constraints in module and try to manage that in the blueprints. |
| output.tf | Output variables to export. |
| README.MD | Short description of the features the module is achieving, the input and output variables. |
| CHANGELOG.MD | Version history, new features, improvements and bugs with version number aligned with GitHub releases. |

## Examples

Each module must have at least an example that must be easy to trigger, you shall use the following structure for examples:
| Filename| Content  |
|--|--|
| README.MD | Short description of the example, the input and output variables. |
| locals.tf | Contains the local variable that are necessary to make the module example working. |
| outputs.tf | Output variables to export.|
| test.tf | Contains the logic of the test that will call the module locally and will include dependencies to make the example working |  

In examples, please use *caf_random* or *random* naming convention in order to avoid naming collisions.

## Unit and Integration testing

Each module must implement integration and unit testing using GitHub Actions following the example here:https://github.com/aztfmod/terraform-azurerm-caf-resource-group

Please refer to the unit and integration testing reference article:  https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/test/unit_test.md

## Module Diagnostics

In order to allow flexibility, the diagnostics settings for each module will be passed as variable with the following object:

```hcl
diag_object = {
    log = [
           ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period] 
                ["AzureBackupReport", true, true, 20],
        ]
    metric = [
               #["AllMetrics", 60, True],
    ]
}
```

## Module Output conventions

As a convention we will use the following minimal module outputs:

| Output variable name | Content  |
|--|--|
| id  |  returns the object identifiers|
| name | returns the object name |
| object | returns the full resource object |

Any other resource specific outputs.