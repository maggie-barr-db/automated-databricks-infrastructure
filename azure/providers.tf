provider "azurerm" {
  features {}
}

provider "databricks" {
  # Uses Azure AD auth from `az login`; points to this workspace
  azure_workspace_resource_id = azurerm_databricks_workspace.workspace.id
}


