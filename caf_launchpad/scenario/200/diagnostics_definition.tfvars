
#
# Define a set of settings for the various type of Azure resources
#

diagnostics_definition = {
  log_analytics = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Audit", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  default_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  bastion_host = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["BastionAuditLogs", true, false, 0],
      ]
    }

  }

  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, false, 0],
        ["DDoSMitigationFlowLogs", true, false, 0],
        ["DDoSMitigationReports", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  network_security_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["NetworkSecurityGroupEvent", true, false, 0],
        ["NetworkSecurityGroupRuleCounter", true, false, 0],
      ]
    }

  }

  network_interface_card = {
    name = "operational_logs_and_metrics"
    categories = {
      # log = [
      #   # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
      #   ["AuditEvent", true, false, 0],
      # ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  azure_container_registry = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ContainerRegistryRepositoryEvents", true, false, 0],
        ["ContainerRegistryLoginEvents", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }
  }

  azure_kubernetes_cluster = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["kube-apiserver", true, false, 0],
        ["kube-audit", true, false, 0],
        ["kube-audit-admin", true, false, 0],
        ["kube-controller-manager", true, false, 0],
        ["kube-scheduler", true, false, 0],
        ["cluster-autoscaler", true, false, 0],
        ["guard", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }
  }

  azure_site_recovery = {
    name                           = "operational_logs_and_metrics"
    log_analytics_destination_type = "Dedicated"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AzureBackupReport", true, true, 0],
        ["CoreAzureBackup", true, true, 0],
        ["AddonAzureBackupAlerts", true, true, 0],
        ["AddonAzureBackupJobs", true, true, 0],
        ["AddonAzureBackupPolicy", true, true, 0],
        ["AddonAzureBackupProtectedInstance", true, true, 0],
        ["AddonAzureBackupStorage", true, true, 0],
        ["AzureSiteRecoveryJobs", true, true, 0],
        ["AzureSiteRecoveryEvents", true, true, 0],
        ["AzureSiteRecoveryReplicatedItems", true, true, 0],
        ["AzureSiteRecoveryReplicationStats", true, true, 0],
        ["AzureSiteRecoveryRecoveryPoints", true, true, 0],
        ["AzureSiteRecoveryReplicationDataUploadRate", true, true, 0],
        ["AzureSiteRecoveryProtectedDiskDataChurn", true, true, 0],
      ]
      metric = [
        #["AllMetrics", 60, True],
      ]
    }

  }

  azure_automation = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["JobLogs", true, true, 0],
        ["JobStreams", true, true, 0],
        ["DscNodeStatus", true, true, 0],
      ]
      metric = [
        # ["Category name",  "Metric Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, true, 0],
      ]
    }

  }

  event_hub_namespace = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ArchiveLogs", true, false, 0],
        ["OperationalLogs", true, false, 0],
        ["AutoScaleLogs", true, false, 0],
        ["KafkaCoordinatorLogs", true, false, 0],
        ["KafkaUserErrorLogs", true, false, 0],
        ["EventHubVNetConnectionEvent", true, false, 0],
        ["CustomerManagedKeyUserLogs", true, false, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 0],
      ]
    }

  }

  compliance_all = {
    name = "compliance_logs"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, true, 0],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 0],
      ]
    }

  }

  siem_all = {
    name = "siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, true, 0],
      ]

      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 0],
      ]
    }

  }

  subscription_operations = {
    name = "subscription_operations"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"]
        ["Administrative", true],
        ["Security", true],
        ["ServiceHealth", true],
        ["Alert", true],
        ["Policy", true],
        ["Autoscale", true],
        ["ResourceHealth", true],
        ["Recommendation", true],
      ]
    }
  }

  subscription_siem = {
    name = "activity_logs_for_siem"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)"]
        ["Administrative", false],
        ["Security", true],
        ["ServiceHealth", false],
        ["Alert", false],
        ["Policy", true],
        ["Autoscale", false],
        ["ResourceHealth", false],
        ["Recommendation", false],
      ]
    }

  }

}