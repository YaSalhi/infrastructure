resource "azurerm_mssql_server" "sql" {
  name                         = var.server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      tags,
      administrator_login_password
    ]
  }

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_mssql_database" "db" {
  name                        = var.db_name
  server_id                   = azurerm_mssql_server.sql.id
  sku_name                    = var.sku_name
  storage_account_type        = "Local"  # Use local redundancy instead of geo-redundant
  zone_redundant             = false
  geo_backup_enabled         = false

  depends_on = [
    azurerm_mssql_server.sql
  ]
}

