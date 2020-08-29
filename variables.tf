variable "location" {
  default     = "UK South"
  description = "Location for the resource group and storage account."
}

variable "cdn_location" {
  default     = "West Europe"
  description = "Location for the CDN profile and endpoint."
}

variable "endpoint" {
  description = "CDN endpoint name (XX.azureedge.net)"
}

variable "storage_account_name" {
  description = "The name of the storage account, must be globaly unique"
}
