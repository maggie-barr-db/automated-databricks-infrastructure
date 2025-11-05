output "resource_group_name" {
  value       = data.azurerm_resource_group.rg.name
  description = "Azure Resource Group name."
}

output "storage_account_name" {
  value       = azurerm_storage_account.adls.name
  description = "ADLS Gen2 Storage Account name."
}

output "storage_account_id" {
  value       = azurerm_storage_account.adls.id
  description = "ADLS Gen2 Storage Account resource ID."
}

output "storage_dfs_endpoint" {
  value       = "https://${azurerm_storage_account.adls.name}.dfs.core.windows.net"
  description = "Data Lake (dfs) endpoint URL for the storage account."
}

output "storage_filesystem_name" {
  value       = azurerm_storage_data_lake_gen2_filesystem.fs.name
  description = "ADLS Gen2 filesystem (container) name."
}

output "databricks_workspace_name" {
  value       = azurerm_databricks_workspace.workspace.name
  description = "Databricks workspace name."
}

output "databricks_workspace_resource_id" {
  value       = azurerm_databricks_workspace.workspace.id
  description = "Azure Resource ID of the Databricks workspace."
}

output "databricks_workspace_url" {
  value       = azurerm_databricks_workspace.workspace.workspace_url
  description = "Workspace URL to use with the Databricks CLI."
}

 


