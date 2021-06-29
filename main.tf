locals {
  cheapest_region = data.external.get_region.result.region
  p = data.external.get_region.result.saving_percentage_pay_as_you_go
  saving_on_payg = local.p != "" ? floor(local.p) : local.p
  y = data.external.get_region.result.saving_percentage_one_year_reserved 
  saving_on_yearly_reserved  = local.y != "" ? floor(local.y) : "[unknown]"
}

output "post_region" {
  value = local.cheapest_region
}

output "vm_size" {
  value = var.vm_size
}

output "payg" {
  value = local.saving_on_payg
}

output "yearly_reserved" {
  value = local.saving_on_yearly_reserved
}