## Extensions have moved! We now have them inside the module directly to improve graph processing
## The moved instructions are supported Terraform 1.1 and are to be removed after a couple of release.

moved {
  from = module.vmss_extension_custom_scriptextension
  to   = module.solution.module.vmss_extension_custom_scriptextension
}

moved {
  from = module.vmss_extension_microsoft_azure_domainjoin
  to   = module.solution.module.vmss_extension_microsoft_azure_domainjoin
}