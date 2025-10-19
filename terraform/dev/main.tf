# Resource Group
resource "azurerm_resource_group" "rg_dev" {
  name     = "rg-dev-env"
  location = "West Europe"
}

# App Service Plan
resource "azurerm_service_plan" "plan_dev" {
  name                = "plan-dev-env"
  resource_group_name = azurerm_resource_group.rg_dev.name
  location            = azurerm_resource_group.rg_dev.location
  os_type             = "Linux"
  sku_name            = "F1"
}

# Web App
resource "azurerm_linux_web_app" "app_dev" {
  name                = "webapp-dev-env"
  resource_group_name = azurerm_resource_group.rg_dev.name
  location            = azurerm_resource_group.rg_dev.location
  service_plan_id     = azurerm_service_plan.plan_dev.id

  site_config {
    application_stack {
      node_version = "18-lts"
    }

     always_on = false
  }
}

  # comme ma suscription ne donne pas la possibilité de crée le bdd dans (Europe) West Europe j'ai choisi  northeurope
  #il est important de garder les ressources proches (même région ou région proche) pour limiter la latence.
  # * tjrs vérifier que la location choisi pour votre rg a tous les services de votre projet  
  variable "sql_location" {
    default = "northeurope"
  }

  variable "sql_admin_password" {
    description = "Mot de passe administrateur SQL"
    type        = string
    sensitive   = true
    default     = "Password123!" # Pour tests seulement, sinon utiliser Key Vault ou secret pipeline
  }

  # database 
  resource "azurerm_mssql_server" "sql" {
  name                         = "server-dev-env"
  resource_group_name          = azurerm_resource_group.rg_dev.name
  #location                     = azurerm_resource_group.rg_dev.location *
  location = var.sql_location
  version                      = "12.0"
  administrator_login          = "azureadmin"
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "db" {
  name           = "db-dev-env"
  server_id      = azurerm_mssql_server.sql.id
  sku_name       = "S0"
}

