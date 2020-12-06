resource "azurerm_resource_group" "web_rg" {
  name     = "website-rg"
  location = var.location
}

resource "azurerm_storage_account" "web_sa" {
  name                      = var.storage_account_name
  resource_group_name       = azurerm_resource_group.web_rg.name
  location                  = var.location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = var.sa_replication_type
  allow_blob_public_access  = true
  enable_https_traffic_only = false

  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}
