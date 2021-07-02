azurerm_firewalls = {
  firewall1 = {
    name               = "test-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Premium"
    resource_group_key = "hub_re1"
    vnet_key           = "vnet_re1"
    virtual_hub = {
      hub1 = {
        virtual_wan_key = "vwan_re1"
        virtual_hub_key = "hub_re1"
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
      }
    }
  }
  firewall2 = {
    name               = "test-firewall"
    sku_name           = "AZFW_Hub"
    sku_tier           = "Premium"
    resource_group_key = "hub_re2"
    vnet_key           = "vnet_re2"
    virtual_hub = {
      hub1 = {
        virtual_wan_key = "vwan_re1"
        virtual_hub_key = "hub_re2"
        #virtual_hub_id = "Azure_resource_id"
        #lz_key = "lz_key"
        public_ip_count = 1
      }
    }
  }
}