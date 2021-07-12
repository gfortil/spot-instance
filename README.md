# Azure - Cheapest Spot Region

## Introduction

This module returns the current cheapest spot region as a string.

## Providers

| Name | Version |
|------|---------|
| azurerm | >= 2.57.0 |

## Input Variables

| Name |Description|Type| 
|----|-----------|----|
| vm_size | The size of the virtual machine that is intended to be used for the AKS deployment. | string |
| rank |  Returns the cheapest, the second, or another rank. | string |

## Outputs

| Name | Description |
|------|-------------|
| post_region | Outputs the cheapest region based on the VM size and rank |
| vm_size | Returns the VM size |
| current_price | Returns the current price for a spot instance of the specified size in the cheapest spot region |
| payg_price | Returns the price for a standard instance in the same region based on the pay-as-you-go model |
| saving_on_payg | Returns the current percentage of saving on a pay-as-you-go instance |

## Example

~~~~
module "cheapest_spot_region" {
  source  = "../../terraform-azurerm-cheapest-region"

  vm_size = "Standard_A4_v2"
  rank    = 1
}

module "kubernetes" {
  # source = "github.com/Azure-Terraform/terraform-azurerm-kubernetes.git?ref=v1.5.1"
  source = "../../terraform-azurerm-kubernetes"
  
  location                 = module.metadata.location
  names                    = module.metadata.names
  tags                     = module.metadata.tags
  kubernetes_version       = "1.18.17"
  resource_group_name      = module.resource_group.name

  default_node_pool_name                = "default"
  default_node_pool_vm_size             = "Standard_A4_v2"
  default_node_pool_enable_auto_scaling = true
  default_node_pool_node_min_count      = 3
  default_node_pool_node_max_count      = 6
  # default_node_pool_availability_zones  = [1,2,3]

  enable_kube_dashboard = true

  additional_node_pool = {
    name                          = "nodepool1"
    node_count                    = 1
    vm_size                       = module.cheapest_spot_region.vm_size
    priority                      = "Spot"
    mode                          = "User"
    node_labels                   = {
                                      "current_price":module.cheapest_spot_region.current_price, 
                                      "payg_price":module.cheapest_spot_region.payg_price
                                    }
    node_taints                   = null
    eviction_policy               = "Delete"
    os_type                       = "Linux"
    proximity_placement_group_id  = null
    spot_max_price                = -1
  }
}
~~~~
