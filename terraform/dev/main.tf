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
