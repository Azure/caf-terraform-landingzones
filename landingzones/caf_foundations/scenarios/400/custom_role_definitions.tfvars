# https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
# https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations

custom_role_definitions = {

  register_subscriptions_providers = {
    name = "caf-authorized-azure-providers"
    permissions = {
      actions = [
        # General
        "Microsoft.Marketplace/register/action",
        "Microsoft.Addons/register/action",
        "Microsoft.ManagedIdentity/register/action",
        "Microsoft.ResourceHealth/register/action",
        "Microsoft.Support/register/action",

        # Compute
        "Microsoft.ClassicCompute/register/action",
        "Microsoft.Compute/register/action",
        "Microsoft.ServiceFabric/register/action",
        "Microsoft.HybridCompute/register/action",

        # Networking
        "Microsoft.Cdn/register/action",
        "Microsoft.ClassicNetwork/register/action",
        "Microsoft.Network/register/action",

        # Storage
        "Microsoft.ClassicStorage/register/action",
        "Microsoft.DataBox/register/action",
        "Microsoft.ImportExport/register/action",
        "Microsoft.NetApp/register/action",
        "Microsoft.Storage/register/action",
        "microsoft.storagesync/register/action",
        "Microsoft.StorSimple/register/action",

        # Web
        "Microsoft.CertificateRegistration/register/action",
        "Microsoft.DomainRegistration/register/action",
        "Microsoft.Maps/register/action",
        "Microsoft.Media/register/action",
        "Microsoft.Search/register/action",
        "Microsoft.SignalRService/register/action",
        "microsoft.web/register/action",

        # Container
        "Microsoft.ContainerInstance/register/action",
        "Microsoft.ContainerService/register/action",
        "Microsoft.DevSpaces/register/action",

        # Databases
        "Microsoft.Cache/register/action",
        "Microsoft.DataFactory/register/action",
        "Microsoft.DataMigration/register/action",
        "Microsoft.DBforMariaDB/register/action",
        "Microsoft.DBforMySQL/register/action",
        "Microsoft.DBforPostgreSQL/register/action",
        "Microsoft.DocumentDB/register/action",
        "Microsoft.Sql/register/action",
        "Microsoft.SqlVirtualMachine/register/action",

        # Analytics
        "Microsoft.AnalysisServices/register/action",
        "Microsoft.Databricks/register/action",
        "Microsoft.DataLakeAnalytics/register/action",
        "Microsoft.DataLakeStore/register/action",
        "Microsoft.EventHub/register/action",
        "Microsoft.HDInsight/register/action",
        "Microsoft.Kusto/Register/action",
        "Microsoft.PowerBIDedicated/register/action",
        "Microsoft.StreamAnalytics/Register/action",

        # Blockchain
        "Microsoft.Blockchain/register/action",

        # AI - machine learning
        "Microsoft.CognitiveServices/register/action",
        "Microsoft.MachineLearning/register/action",
        "Microsoft.MachineLearningServices/register/action",

        # Internet of things
        "Microsoft.Devices/register/action",
        "Microsoft.IoTCentral/register/action",
        "Microsoft.NotificationHubs/register/action",
        "Microsoft.TimeSeriesInsights/register/action",

        # Mixed Reality - https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations#mixed-reality
        "Microsoft.IoTSpaces/register/action",
        "Microsoft.MixedReality/register/action",

        # Integration
        "Microsoft.ApiManagement/register/action",
        "Microsoft.AppConfiguration/register/action",
        "Microsoft.AzureStack/register/action",
        "Microsoft.DataCatalog/register/action",
        "Microsoft.EventGrid/register/action",
        "Microsoft.Logic/register/action",
        "Microsoft.Relay/register/action",
        "Microsoft.ServiceBus/register/action",

        # Identity
        "Microsoft.AAD/register/action",
        "Microsoft.ADHybridHealthService/register/action",
        "Microsoft.AzureActiveDirectory/register/action",
        "Microsoft.ManagedIdentity/register/action",

        # Security
        "Microsoft.KeyVault/register/action",
        "Microsoft.Security/register/action",
        "Microsoft.SecurityInsights/register/action",

        # Devops
        "Microsoft.DevTestLab/register/action",
        "Microsoft.LabServices/register/action",
        "Microsoft.VisualStudio/Register/Action",

        # Migrate
        "Microsoft.Migrate/register/action",
        "Microsoft.OffAzure/register/action",

        # Monitor
        "Microsoft.AlertsManagement/register/action",
        "Microsoft.Insights/Register/Action",
        "microsoft.operationalinsights/register/action",
        "Microsoft.OperationsManagement/register/action",

        # Management and Governance
        "Microsoft.Advisor/register/action",
        "Microsoft.Automation/register/action",
        "Microsoft.Batch/register/action",
        "Microsoft.Billing/register/action",
        "Microsoft.Blueprint/register/action",
        "Microsoft.Capacity/register/action",
        "Microsoft.Commerce/register/action",
        "Microsoft.Consumption/register/action",
        "Microsoft.CostManagement/register/action",
        "Microsoft.CostManagement/tenants/register/action",
        "Microsoft.Features/register/action",
        "Microsoft.Features/providers/features/register/action",
        "Microsoft.GuestConfiguration/register/action",
        "Microsoft.ManagedServices/register/action", # Lighthouse
        "Microsoft.Management/register/action",      # Mangement groups
        "Microsoft.PolicyInsights/register/action",
        "Microsoft.Portal/register/action",
        "Microsoft.RecoveryServices/register/action",
        "Microsoft.Solutions/register/action", # Azure Managed Applications
        "Microsoft.Subscription/register/action",

        # Unregister
        "Microsoft.Solutions/unregister/action",
        "Microsoft.PolicyInsights/unregister/action",
        "Microsoft.ManagedServices/unregister/action",
        "Microsoft.HybridCompute/unregister/action",
        "Microsoft.Features/providers/features/unregister/action",
        "Microsoft.Commerce/unregister/action",
        "Microsoft.Capacity/unregister/action",
        "Microsoft.Batch/unregister/action",
        "Microsoft.Advisor/unregister/action",
        "microsoft.operationalinsights/unregister/action",
        "Microsoft.Insights/Unregister/Action",
        "Microsoft.SecurityInsights/unregister/action",
        "Microsoft.Security/unregister/action",
        "Microsoft.KeyVault/register/action",
        "Microsoft.ADHybridHealthService/unregister/action",
        "Microsoft.AAD/unregister/action",
        "Microsoft.ServiceBus/unregister/action",
        "Microsoft.ResourceHealth/unregister/action",
        "Microsoft.Compute/unregister/action",
        "Microsoft.Network/unregister/action",
        "Microsoft.DataBox/unregister/action",
        "Microsoft.NetApp/unregister/action",
        "microsoft.storagesync/unregister/action",
        "Microsoft.Media/unregister/action",
        "Microsoft.SignalRService/unregister/action",
        "microsoft.web/unregister/action",
        "Microsoft.ContainerService/unregister/action",
        "Microsoft.Cache/unregister/action",
        "Microsoft.DataFactory/unregister/action",
        "Microsoft.Sql/unregister/action",
        "Microsoft.SqlVirtualMachine/unregister/action",
        "Microsoft.EventHub/unregister/action",
        "Microsoft.HDInsight/unregister/action",
        "Microsoft.Kusto/Unregister/action",
        "Microsoft.NotificationHubs/unregister/action",
        "Microsoft.ApiManagement/unregister/action",
        "Microsoft.AppConfiguration/unregister/action",
        "Microsoft.DataCatalog/unregister/action",
        "Microsoft.EventGrid/unregister/action",
        "Microsoft.Relay/unregister/action",
      ]
    }
  }

}

