terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.11.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = ">=2.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  # export ARM_SUBSCRIPTION_ID="xxxx-xxxx-xxxx-xxxx" to avoid hardcoding the subscription_id
}

provider "azapi" {
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

# Commented out, replaced with azapi_resource.adf so billing config can be managed
# resource "azurerm_data_factory" "adf" {
#   name                = "${var.prefix}-adf"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
# }

resource "azapi_resource" "adf" {
  type                      = "Microsoft.DataFactory/factories@2018-06-01"
  name                      = "${var.prefix}-adf"
  location                  = azurerm_resource_group.rg.location
  parent_id                 = azurerm_resource_group.rg.id
  schema_validation_enabled = false

  body = {
    properties = {
      globalConfigurations = {
        PipelineBillingEnabled = "true"
      }
    }
  }
}
