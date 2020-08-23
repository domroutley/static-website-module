resource "azurerm_resource_group" "web_rg" {
  name     = "website-rg"
  location = var.location
}

resource "azurerm_storage_account" "web_sa" {
  name                     = "websitesdomroutley"
  resource_group_name      = azurerm_resource_group.web_rg.name
  location                 = var.location
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = true
  enable_https_traffic_only = false
  custom_domain {
    name = "dom.routley.info"
    use_subdomain = true
  }
  static_website {
    index_document = "index.html"
    # error_404_document = ""
  }
}

# resource "azurerm_cdn_profile" "web_cdn_profile" {
#   name                = "website-cdn"
#   location            = var.cdn_location
#   resource_group_name = azurerm_resource_group.web_rg.name
#   sku                 = "Standard_Microsoft"
# }

# resource "azurerm_cdn_endpoint" "web_cdn_endpoint" {
#   name                = "web-cdn-endpoint"
#   profile_name        = azurerm_cdn_profile.web_cdn_profile.name
#   location            = var.cdn_location
#   resource_group_name = azurerm_resource_group.web_rg.name

#   origin {
#     name      = "web-origin"
#     host_name = azurerm_storage_account.web_sa.primary_web_host
#   }
# }
