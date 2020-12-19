output "endpoint_web_url" {
  value = "https://${var.endpoint}.azureedge.net/"
}

output "storage_account_web_url" {
  value = azurerm_storage_account.web_sa.primary_web_endpoint
}

output "storage_account_name" {
  value = azurerm_storage_account.web_sa.name
}
