# Blueprint blueprint_tranquility
Blueprint_tranquility is the first blueprint to deploy. <br/>
It's job is to provide with the foundations of security and auditing for an Azure deployment with come customization capabilities. <br/>
After running, tranquility exports to the shared TF state a set of output variables thast will be reused in subsequent blueprints.  

## Getting Started
As an example of configuration, use the foundations.auto.tfvars provided in the repository. 
 <br/>
 In order to get started with blueprint_tranquility, simply run: 
```
./launchpad.sh blueprint_tranquility apply
```
## Components

![tranquility diagram](https://raw.githubusercontent.com/aztfmod/blueprints/master/blueprint_tranquility/tranquility.png "tranquility diagram")

## Capabilities

 - Resource groups
    - Core resource groups needed for hub-spoke topology.
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


## Customization 
The provided foundations.auto.tfvars allows you to deploy your first version of blueprint_tranquility and see the typical options

## Foundations
The output of blueprint_tranquility will be stored in Azure Storage Account and will be read by subsequent modules. <br/> Please do not modify the provided output variables but add additionnal below if you need to extend the model.

# Contribute
Pull requests are welcome to evolve the framework and integrate new features!