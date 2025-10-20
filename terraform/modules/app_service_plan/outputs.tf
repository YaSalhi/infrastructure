output "app_service_name" {
  value = azurerm_service_plan.plan.name
}

/*output "app_service_default_hostname" {
  value = azurerm_service_plan.plan.default_site_hostname
}*/
output "plan_id" {
  value = azurerm_service_plan.plan.id
}
