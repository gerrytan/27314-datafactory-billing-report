provider "azurerm" {
  features {}
  # export ARM_SUBSCRIPTION_ID="xxxx-xxxx-xxxx-xxxx" to avoid hardcoding the subscription_id
}

variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_data_factory" "adf" {
  name                = "${var.prefix}-adf"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  # Toggle this parameter to force update resource
  global_parameter {
    name  = "intVal"
    type  = "Int"
    value = "3"
  }
}
