resource_groups_hub_ids = terraform output -json resource_group_hub_ids | jq 
log_analytics_worskpace_name = terraform output -json  log_analytics_workspace