variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for Event Hub"
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

variable "event_hub_namespace_name" {
  description = "Name of the Event Hub namespace"
  type        = string
}

variable "event_hub_names" {
  description = "List of Event Hub names to create"
  type        = list(string)
  default     = ["data-ingestion", "alerts"]
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}
