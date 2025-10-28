resource "azurerm_linux_web_app" "app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      node_version = var.node_version
    }
    always_on = var.always_on
  }

    depends_on = [
    var.resource_group_name
  ]

  lifecycle {
  prevent_destroy = true
}

  
}
