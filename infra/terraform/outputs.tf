output "web_app_url" {
  description = "HTTPS URL of the Service Status API Web App."
  value       = "https://${azurerm_linux_web_app.api.default_hostname}"
}
