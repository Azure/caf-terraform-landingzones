# Blueprint blueprint_tranquility
Blueprint_tranquility is the first blueprint to deploy. <br/>
It's job is to provide with the foundations of security and auditing for an Azure deployment with come customization capabilities. <br/>

# Overall architecture
The following diagram shows the environment we are deploying in this blueprint: 
![Tranquility](https://github.com/aztfmod/landingzones/blob/master/landingzone_vdc_demo/docs/diagram-tranquility.png)


## Capabilities

 - Resource groups
    - Core resource groups needed for hub site deployment.
 - Activity Logging
    - Auditing all subscription activities and archiving
        - Storage Account
        - Event Hubs 
 - Diagnostics Logging
    - All operations logs kept for x days 
        - Storage Account
        - Event Hubs 
 - Log Analytics
    - Stores all the operations logs
    - Common solutions for deep application best practices review:
        - NetworkMonitoring
        - ADAssessment
        - ADReplication
        - AgentHealthAssessment
        - DnsAnalytics
        - KeyVaultAnalytics
- Security Center
    - Security hygiene metrics and alerts 


# Contribute
This is a demo environement but pull requests are welcome to evolve the framework and integrate new features!