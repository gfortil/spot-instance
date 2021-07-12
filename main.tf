locals {
  cheapest_region = data.external.get_region.result.region
  current_price   = data.external.get_region.result.spot_mean_api
  payg_price      = data.external.get_region.result.pay_as_you_go_mean
  saving_on_payg  = ceil(abs(((local.current_price * 100)/local.payg_price) - 100))
}

output "post_region" {
  value = local.cheapest_region
}

output "vm_size" {
  value = var.vm_size
}

output "current_price" {
  value = local.current_price
}

output "payg_price" {
  value = local.payg_price
}

output "saving_on_payg" {
  value = local.saving_on_payg
}
