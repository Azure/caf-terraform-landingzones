#!/usr/bin/env bats

@test "Simple check for date command" {
  date
}

@test  "validation accounting resource group" {
    result=$(az graph query -q "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' | where tags['blueprint'] =~ 'blueprint_foundations_accounting'" | jq 'length')
    code=$?
    [ $result -eq 2 ]
    [ $code -eq 0 ]
}

@test  "validation storage account in 'HUB-CORE-SEC'" {
    result=$(az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' | count" | jq .[].Count)
    code=$?
    [ $result -eq 1 ]
    [ $code -eq 0 ]
}

@test  "validation storage account in 'HUB-CORE-SEC' is tagged with Terraform" {
    location=$(az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .properties.primaryLocation')
    code=$?
    [ $location = "\"southeastasia\"" ]
    [ $code -eq 0 ]
    tag=$(az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .tags["deploymentType"]')
    code=$?
    [ "$tag" = "\"Terraform\"" ]
    [ $code -eq 0 ]
}

@test  "validation event hub in 'HUB-CORE-SEC'" {
    count=$(az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'Microsoft.EventHub/namespaces' | count" | jq .[].Count)
    code=$?
    [ $count -eq 1 ]
    [ $code -eq 0 ]
    location=$( az graph query -q "Resources | where resourceGroup contains 'HUB-CORE-SEC' and type =~ 'Microsoft.EventHub/namespaces'" | jq .[].location)
    code=$?
    [ "$location" = "\"southeastasia\"" ]
    [ $code -eq 0 ]
}

@test  "validation 'HUB-OPERATION' resource group" {
    count=$(az graph query -q "ResourceContainers | where type =~ 'microsoft.resources/subscriptions/resourcegroups' | where name contains '-hub-operations'" | jq 'length')
    code=$?
    [ $count -eq 1 ]
    [ $code -eq 0 ]
}

@test  "validation 'HUB-OPERATION' resource count" {
    count=$(az graph query -q "Resources | where resourceGroup contains '-hub-operations'" | jq 'length')
    code=$?
    [ $count -eq 10 ]
    [ $code -eq 0 ]
}

@test  "validation 'HUB-OPERATION' azure monitor logs" {
    count=$(az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'Microsoft.OperationalInsights/workspaces'" | jq 'length')
    code=$?
    [ $count -eq 1 ]
    [ $code -eq 0 ]
    name=$(az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'Microsoft.OperationalInsights/workspaces'" | jq '.[0].name | contains("lalogs")')
    code=$?
    [ $name = true ]
    [ $code -eq 0 ]
}

@test  "validation 'HUB-OPERATION' storage account" {
    count=$(az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'microsoft.storage/storageaccounts' | count" | jq .[].Count)
    code=$?
    [ $count -eq 1 ]
    [ $code -eq 0 ]
    location=$(az graph query -q "Resources | where resourceGroup contains '-hub-operations' and type =~ 'microsoft.storage/storageaccounts' " | jq '.[0] | .properties.primaryLocation')
    code=$?
    [ $location = "\"southeastasia\"" ]
    [ $code -eq 0 ]
}

@test  "validating GOVERNANCE POLICIES" {
    policy_no_managed_disks=$(az policy assignment list | jq '.[] | select(.name | contains("vm_no_managed_disks")) | .name')
    code=$?
    [ $policy_no_managed_disks = "\"vm_no_managed_disks\"" ]
    [ $code -eq 0 ]
}