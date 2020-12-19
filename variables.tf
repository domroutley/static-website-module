variable "endpoint" {
  description = "CDN endpoint name (XX.azureedge.net)"
}

variable "storage_account_name" {
  description = "The name of the storage account, must be globaly unique."
}

variable "location" {
  default     = "UK South"
  description = "Location for the resource group and storage account."
}

variable "cdn_location" {
  default     = "West Europe"
  description = "Location for the CDN profile and endpoint."
}

variable "sa_replication_type" {
  description = "The storage account replication type. Valid values are: LRS, ZRS, GRS, RA-GRS"
  default     = "LRS"
  validation {
    condition = contains(
      ["LRS", "ZRS", "GRS", "RA-GRS"],
      var.sa_replication_type
    )
    error_message = "Variable sa_replication_type must be one of: LRS, ZRS, GRS, RA-GRS."
  }
}

variable "resource_group_name" {
  description = "The name of the resource group to store all resources in."
  default     = "website-rg"
}
