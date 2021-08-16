vnets = {
  vnet_re1 = {
    resource_group_key = "vnet_re1"
    region             = "region1"
    vnet = {
      name          = "hub-re1"
      address_space = ["10.10.100.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.10.100.192/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.10.100.160/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }
  }
  vnet_re2 = {
    resource_group_key = "vnet_re2"
    region             = "region2"
    vnet = {
      name          = "hub-re2"
      address_space = ["10.10.101.0/24"]
    }
    specialsubnets = {
      AzureFirewallSubnet = {
        name = "AzureFirewallSubnet" #Must be called AzureFirewallSubnet
        cidr = ["10.10.101.192/26"]
      }
    }
    subnets = {
      AzureBastionSubnet = {
        name    = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr    = ["10.10.101.160/27"]
        nsg_key = "azure_bastion_nsg"
      }
    }
  }
}