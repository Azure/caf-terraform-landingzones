
custom_role_definitions = {
  caf-launchpad = {
    name        = "caf-launchpad"
    useprefix   = true
    description = "Provide addition permissions on top of built-in Contributor role to manage landing zones deployment"
    permissions = {
      actions = [
        "Microsoft.Authorization/roleAssignments/delete",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleDefinitions/delete",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "microsoft.insights/diagnosticSettings/delete",
        "microsoft.insights/diagnosticSettings/read",
        "microsoft.insights/diagnosticSettings/write",
        "Microsoft.KeyVault/vaults/delete",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.KeyVault/vaults/write",
        "Microsoft.KeyVault/vaults/accessPolicies/write",
        "Microsoft.Network/networkSecurityGroups/delete",
        "Microsoft.Network/networkSecurityGroups/read",
        "Microsoft.Network/networkSecurityGroups/write",
        "Microsoft.Network/networkSecurityGroups/join/action",
        "Microsoft.Network/virtualNetworks/subnets/delete",
        "Microsoft.Network/virtualNetworks/subnets/read",
        "Microsoft.Network/virtualNetworks/subnets/write",
        "Microsoft.OperationalInsights/workspaces/delete",
        "Microsoft.OperationalInsights/workspaces/read",
        "Microsoft.OperationalInsights/workspaces/write",
        "Microsoft.OperationalInsights/workspaces/sharedKeys/action",
        "Microsoft.OperationsManagement/solutions/delete",
        "Microsoft.OperationsManagement/solutions/read",
        "Microsoft.OperationsManagement/solutions/write",
        "Microsoft.Storage/storageAccounts/delete",
        "Microsoft.Storage/storageAccounts/read",
        "Microsoft.Storage/storageAccounts/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
        "Microsoft.Storage/storageAccounts/blobServices/containers/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/write",
        "Microsoft.Storage/storageAccounts/blobServices/containers/lease/action",
        "Microsoft.Storage/storageAccounts/blobServices/read",
        "Microsoft.Storage/storageAccounts/listKeys/action",
        "Microsoft.Resources/subscriptions/providers/read",
        "Microsoft.Resources/subscriptions/read",
        "Microsoft.Resources/subscriptions/resourcegroups/delete",
        "Microsoft.Resources/subscriptions/resourcegroups/read",
        "Microsoft.Resources/subscriptions/resourcegroups/write",
        "Microsoft.Network/virtualNetworks/delete",
        "Microsoft.Network/virtualNetworks/read",
        "Microsoft.Network/virtualNetworks/write",
      ]
    }

  }

  caf-launchpad-contributor = {
    name        = "caf-launchpad-contributor"
    useprefix   = true
    description = "Provide addition permissions on top of built-in Contributor role to manage landing zones deployment"
    permissions = {
      actions = [
        "Microsoft.Authorization/roleAssignments/delete",
        "Microsoft.Authorization/roleAssignments/read",
        "Microsoft.Authorization/roleAssignments/write",
        "Microsoft.Authorization/roleDefinitions/delete",
        "Microsoft.Authorization/roleDefinitions/read",
        "Microsoft.Authorization/roleDefinitions/write",
        "Microsoft.Resources/subscriptions/providers/read"
      ]
    }
  }

}

