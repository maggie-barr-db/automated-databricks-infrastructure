locals {
  # Azure Storage Account name: 3-24 chars, lowercase, alphanumeric only
  sa_name = substr("${lower(replace(replace(var.project_name, "-", ""), "_", ""))}${random_string.sa_suffix.result}", 0, 24)
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg"
  location = var.location

  tags = merge(var.tags, {
    project     = var.project_name
    environment = var.environment
  })
}

resource "random_string" "sa_suffix" {
  length  = 6
  lower   = true
  upper   = false
  numeric = true
  special = false
}

resource "azurerm_storage_account" "adls" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true

  tags = merge(var.tags, {
    project     = var.project_name
    environment = var.environment
  })
}

resource "azurerm_storage_data_lake_gen2_filesystem" "fs" {
  name               = var.storage_container_name
  storage_account_id = azurerm_storage_account.adls.id
}

resource "azurerm_databricks_workspace" "workspace" {
  name                        = "${var.project_name}-dbw"
  resource_group_name         = azurerm_resource_group.rg.name
  location                    = azurerm_resource_group.rg.location
  sku                         = var.databricks_sku
  managed_resource_group_name = "${var.project_name}-dbw-mrg"
  public_network_access_enabled = var.public_network_access_enabled

  tags = merge(var.tags, {
    project     = var.project_name
    environment = var.environment
  })
}


