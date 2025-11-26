variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the storage account"
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

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "container_names" {
  description = "List of container names to create"
  type        = list(string)
  default     = ["raw", "processed", "curated"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
