# Cloud Adoption Framework for Azure - Landing zones on Terraform - Networking

The networking landing zone allows you to deploy most networking topologies on Microsoft Azure. The same landing zone used with different parameters should allow you to deploy most network configurations.

* Hub and spoke
* Virtual WAN
* Application DMZ scenario
* Any custom network topology based on virtual networks or virtual WAN
* Library of network security groups definition

Networking landing zone operates at **level 2**.

For a review of the hierarchy approach of Cloud Adoption Framework for Azure landing zones on Terraform, you can refer to [the following documentation](../../documentation/code_architecture/hierarchy.md).

## Getting started with networking examples

Depending on the networking scenario and topology, we provide you with different examples ready to use:

| level                                                                   | scenario                                                                                                     |
|-------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| [100-single-region-hub](./scenario/100-single-region-hub)               | Simple hub in one region                                                                                     |
| [101-multi-region-hub](./scenario/101-multi-region-hub)                 | Two hubs in different regions with peering                                                                   |
| [105-hub-and-spoke](./scenario/105-hub-and-spoke)                       | Hub and spoke topology in one region                                                                         |
| [106-hub-virtual-wan-firewall](./scenario/106-hub-virtual-wan-firewall) | Azure Virtual WAN topology with virtual hub in multiple regions, optional support for Azure Firewall manager |
| [200-single-region-hub](./scenario/200-single-region-hub)               | Simple hub in one region, with diagnostics                                                                   |
| [201-multi-region-hub](./scenario/201-multi-region-hub)                 | Two hubs in different regions with peering, with diagnostics                                                 |
| [210-aks-private](./scenario/210-aks-private)                           | Hub and spoke topology in one region, with diagnostics                                                       |

## Deploying CAF networking

Once you have picked a scenario for test, you can deploy it using:

```bash
rover -lz /tf/caf/landingzones/caf_networking \
-level level2 \
-var-folder /tf/caf/landingzones/caf_networking/scenario/100-single-region-hub \
-a apply
```
