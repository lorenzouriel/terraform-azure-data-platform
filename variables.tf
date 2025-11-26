# General Azure Variables
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
  sensitive   = true
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  validation {
    condition     = length(var.project_name) <= 20
    error_message = "Project name must be 20 characters or less."
  }
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "eastus"
}

variable "object_id" {
  description = "Object ID of the current user/service principal"
  type        = string
  sensitive   = true
}

# Storage Account Variables
variable "storage_account_name" {
  description = "Name of the storage account (Data Lake)"
  type        = string
  validation {
    condition     = length(var.storage_account_name) >= 3 && length(var.storage_account_name) <= 24
    error_message = "Storage account name must be between 3 and 24 characters."
  }
}

variable "container_names" {
  description = "List of container names in the storage account"
  type        = list(string)
  default     = ["raw", "bronze", "silver", "gold"]
}

# Key Vault Variables
variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
  validation {
    condition     = length(var.key_vault_name) >= 3 && length(var.key_vault_name) <= 24
    error_message = "Key Vault name must be between 3 and 24 characters."
  }
}

# Event Hub Variables
variable "event_hub_namespace_name" {
  description = "Name of the Event Hub namespace"
  type        = string
}

variable "event_hub_names" {
  description = "List of Event Hub names"
  type        = list(string)
  default     = ["data-ingestion", "alerts"]
}

# Data Factory Variables
variable "data_factory_name" {
  description = "Name of the Data Factory"
  type        = string
}

# Databricks Variables
variable "databricks_workspace_name" {
  description = "Name of the Databricks workspace"
  type        = string
}

# Synapse Variables
variable "synapse_workspace_name" {
  description = "Name of the Synapse workspace"
  type        = string
}

variable "synapse_sql_admin_login" {
  description = "SQL admin login for Synapse"
  type        = string
  sensitive   = true
}

variable "synapse_sql_admin_password" {
  description = "SQL admin password for Synapse"
  type        = string
  sensitive   = true
}
