
echo "validation accounting resource group"
blueprint_foundations_accounting_rg_count = az graph query -q "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' | where tags['blueprint'] =~ 'blueprint_foundations_accounting'" | jq 'length'

echo "testing HUB-CORE-SEC"
hub_core_sec_storage_account_count =  az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' | count" | jq .[].Count

hub_core_sec_storage_account_tag_terraform = az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .tags["deploymentType"]'
hub_core_sec_storage_account_primary_location = az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .properties.primaryLocation'

hub_core_sec_event_hub_count = az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'Microsoft.EventHub/namespaces' | count" | jq .[].Count
hub_core_sec_event_hub_location = az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'Microsoft.EventHub/namespaces'" | jq .[].location

echo "testing HUB-OPERATIONS"
hub_operations_rg_count = az graph query -q "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' | where name contains '-hub-operations'" | jq 'length'
hub_operations_resource_count= az graph query -q "Resources | where resourceGroup contains '-hub-operations'" | jq 'length'
hub_operations_monitor_logs_count = az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'Microsoft.OperationalInsights/workspaces'" | jq 'length'
hub_operations_monitor_logs_name = az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'Microsoft.OperationalInsights/workspaces'" | jq '.[0].name | contains("lalogs")'
hub_operations_storage_account_count =  az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'microsoft.storage/storageaccounts' | count" | jq .[].Count
hub_operations_storage_account_primary_location = az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .properties.primaryLocation'

echo "testing GOVERNANCE policies"
policy_vm_no_managed_disks_exists = az policy assignment list | jq '.[] | select(.name | contains("vm_no_managed_disks")) | .name'

