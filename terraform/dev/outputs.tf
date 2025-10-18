output "webapp_url" {
  value = azurerm_linux_web_app.app_dev.default_hostname
}
