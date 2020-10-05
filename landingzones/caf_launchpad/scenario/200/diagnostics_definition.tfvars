
#
# Define the settings for the diagnostics settings
# Demonstrate how to log diagnostics in the correct region
# Different profiles to target different operational teams
#
diagnostics_definition = {
  log_analytics = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["Audit", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  default_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  bastion_host = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["BastionAuditLogs", true, false, 7],
      ]
    }

  }

  networking_all = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["VMProtectionAlerts", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  public_ip_address = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["DDoSProtectionNotifications", true, false, 7],
        ["DDoSMitigationFlowLogs", true, false, 7],
        ["DDoSMitigationReports", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }

  }

  network_security_group = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["NetworkSecurityGroupEvent", true, false, 7],
        ["NetworkSecurityGroupRuleCounter", true, false, 7],
      ]
    }

  }

  nic = {
    name = "operational_logs_and_metrics"
    categories = {
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 7],
      ]
    }
  }

  azure_container_registry = {
    name = "operational_logs_and_metrics"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["ContainerRegistryRepositoryEvents", true, false, 7],
        ["ContainerRegistryLoginEvents", true, false, 7],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", true, false, 7],
      ]
    }
  }

  compliance_all = {
    name = "compliance_logs"
    categories = {
      log = [
        # ["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AuditEvent", true, true, 365],
      ]
      metric = [
        #["Category name",  "Diagnostics Enabled(true/false)", "Retention Enabled(true/false)", Retention_period]
        ["AllMetrics", false, false, 7],
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