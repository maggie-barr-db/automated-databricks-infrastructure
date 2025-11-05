variable "project_name" {
  description = "Short name for all resources (will be used as prefix)."
  type        = string
}

variable "location" {
  description = "Azure region for resources."
  type        = string
  default     = "eastus2"
}

variable "environment" {
  description = "Environment name tag (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default = {
    managed-by = "terraform"
  }
}

variable "storage_container_name" {
  description = "ADLS Gen2 filesystem (container) name."
  type        = string
  default     = "data"
}

variable "databricks_sku" {
  description = "Databricks workspace SKU (standard, premium, or trial)."
  type        = string
  default     = "premium"
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for the Databricks workspace."
  type        = bool
  default     = true
}

## Removed UC-specific variables to avoid requiring account-level permissions

variable "existing_resource_group_name" {
  description = "Name of the existing Azure Resource Group to deploy into (e.g., fe-shared-amer-001)."
  type        = string
}


