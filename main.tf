# Configure the Azure Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Storage Account - Data Lake
module "storage_account_datalake" {
  source = "./modules/storage_account_datalake"

  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  project_name         = var.project_name
  environment          = var.environment
  storage_account_name = var.storage_account_name
  container_names      = var.container_names

  tags = azurerm_resource_group.main.tags

  depends_on = [azurerm_resource_group.main]
}

# Key Vault
module "key_vault" {
  source = "./modules/key_vault"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  project_name        = var.project_name
  environment         = var.environment
  key_vault_name      = var.key_vault_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id

  tags = azurerm_resource_group.main.tags

  depends_on = [azurerm_resource_group.main]
}

# Event Hub
module "event_hub" {
  source = "./modules/event_hub"

  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  project_name             = var.project_name
  environment              = var.environment
  event_hub_namespace_name = var.event_hub_namespace_name
  event_hub_names          = var.event_hub_names

  tags = azurerm_resource_group.main.tags

  depends_on = [azurerm_resource_group.main]
}

# Data Factory
module "data_factory" {
  source = "./modules/data_factory"

  resource_group_name  = azurerm_resource_group.main.name
  location             = azurerm_resource_group.main.location
  project_name         = var.project_name
  environment          = var.environment
  data_factory_name    = var.data_factory_name
  storage_account_id   = module.storage_account_datalake.storage_account_id
  storage_account_name = module.storage_account_datalake.storage_account_name
  key_vault_id         = module.key_vault.key_vault_id
  key_vault_uri        = module.key_vault.key_vault_uri

  tags = azurerm_resource_group.main.tags

  depends_on = [
    azurerm_resource_group.main,
    module.storage_account_datalake,
    module.key_vault
  ]
}

# Databricks
module "databricks" {
  source = "./modules/databricks"

  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  project_name        = var.project_name
  environment         = var.environment
  workspace_name      = var.databricks_workspace_name

  tags = azurerm_resource_group.main.tags

  depends_on = [azurerm_resource_group.main]
}

# Synapse Analytics
module "synapse" {
  source = "./modules/synapse"

  resource_group_name        = azurerm_resource_group.main.name
  location                   = azurerm_resource_group.main.location
  project_name               = var.project_name
  environment                = var.environment
  synapse_workspace_name     = var.synapse_workspace_name
  storage_account_name       = module.storage_account_datalake.storage_account_name
  storage_account_access_key = module.storage_account_datalake.storage_account_access_key
  synapse_filesystem_id      = "${module.storage_account_datalake.storage_account_id}/blobServices/default/containers/curated"
  synapse_sql_admin_login    = var.synapse_sql_admin_login
  synapse_sql_admin_password = var.synapse_sql_admin_password

  tags = azurerm_resource_group.main.tags

  depends_on = [
    azurerm_resource_group.main,
    module.storage_account_datalake
  ]
}
