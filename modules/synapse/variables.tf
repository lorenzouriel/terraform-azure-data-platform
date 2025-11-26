variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for Synapse"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "synapse_workspace_name" {
  description = "Name of the Synapse workspace"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "storage_account_access_key" {
  description = "Access key for the storage account"
  type        = string
  sensitive   = true
}

variable "synapse_filesystem_id" {
  description = "ID of the synapse filesystem (Data Lake Gen2)"
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

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
