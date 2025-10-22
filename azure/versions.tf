terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.115"
    }

    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.55"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}


