resource "azurerm_key_vault" "main" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  network_acls {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    virtual_network_subnet_ids = []
    ip_rules                   = []
  }

  tags = var.tags
}

# Access policy for current user/service principal
resource "azurerm_key_vault_access_policy" "main" {
  key_vault_id = azurerm_key_vault.main.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Update",
  ]

  secret_permissions = [
    "Delete",
    "Get",
    "List",
    "Set",
  ]

  certificate_permissions = [
    "Create",
    "Delete",
    "Get",
    "List",
    "Update",
  ]
}
