## Extensions have moved! We now have them inside the module directly to improve graph processing
## The moved instructions are supported Terraform 1.1 and are to be removed after a couple of release.
moved {
  from = module.vm_extension_monitoring_agent
  to   = module.solution.module.vm_extension_monitoring_agent
}
moved {
  from = module.vm_extension_diagnostics
  to   = module.solution.module.vm_extension_diagnostics
}
moved {
  from = module.vm_extension_microsoft_azure_domainjoin
  to   = module.solution.module.vm_extension_microsoft_azure_domainjoin
}
moved {
  from = module.vm_extension_session_host_dscextension
  to   = module.solution.module.vm_extension_session_host_dscextension
}
moved {
  from = module.vm_extension_custom_scriptextension
  to   = module.solution.module.vm_extension_custom_scriptextension
}