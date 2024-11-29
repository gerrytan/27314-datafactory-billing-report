https://github.com/hashicorp/terraform-provider-azurerm/issues/27314

To reproduce problem:

1. Setup necessary terraform variables in a `variables.auto.tfvars` file, review the variable declarations on `main.tf`
1. `terraform init`, `terraform plan` and `terraform apply`
1. Manually change the "Show billing report" setting via UI
1. Change the `global_parameter` on `main.tf` to force update
1. Do another `terraform apply`

Expected: "Show billing report" persists
Actual: "Show billing report" setting disappears
