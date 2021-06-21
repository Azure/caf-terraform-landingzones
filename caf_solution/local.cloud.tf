locals {
  cloud = merge(
    var.cloud,
    {
      acrLoginServerEndpoint                      = var.acrLoginServerEndpoint
      attestationEndpoint                         = var.attestationEndpoint
      azureDatalakeAnalyticsCatalogAndJobEndpoint = var.azureDatalakeAnalyticsCatalogAndJobEndpoint
      azureDatalakeStoreFileSystemEndpoint        = var.azureDatalakeStoreFileSystemEndpoint
      keyvaultDns                                 = var.keyvaultDns
      mariadbServerEndpoint                       = var.mariadbServerEndpoint
      mhsmDns                                     = var.mhsmDns
      mysqlServerEndpoint                         = var.mysqlServerEndpoint
      postgresqlServerEndpoint                    = var.postgresqlServerEndpoint
      sqlServerHostname                           = var.sqlServerHostname
      storageEndpoint                             = var.storageEndpoint
      storageSyncEndpoint                         = var.storageSyncEndpoint
      synapseAnalyticsEndpoint                    = var.synapseAnalyticsEndpoint
      activeDirectory                             = var.activeDirectory
      activeDirectoryDataLakeResourceId           = var.activeDirectoryDataLakeResourceId
      activeDirectoryGraphResourceId              = var.activeDirectoryGraphResourceId
      activeDirectoryResourceId                   = var.activeDirectoryResourceId
      appInsightsResourceId                       = var.appInsightsResourceId
      appInsightsTelemetryChannelResourceId       = var.appInsightsTelemetryChannelResourceId
      attestationResourceId                       = var.attestationResourceId
      azmirrorStorageAccountResourceId            = var.azmirrorStorageAccountResourceId
      batchResourceId                             = var.batchResourceId
      gallery                                     = var.gallery
      logAnalyticsResourceId                      = var.logAnalyticsResourceId
      management                                  = var.management
      mediaResourceId                             = var.mediaResourceId
      microsoftGraphResourceId                    = var.microsoftGraphResourceId
      ossrdbmsResourceId                          = var.ossrdbmsResourceId
      portal                                      = var.portal
      resourceManager                             = var.resourceManager
      sqlManagement                               = var.sqlManagement
      synapseAnalyticsResourceId                  = var.synapseAnalyticsResourceId
      vmImageAliasDoc                             = var.vmImageAliasDoc
    }
  )
}
