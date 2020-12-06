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
  description = <<EOF
  The storage account replication type.
  Valid values: LRS, ZRS, GRS, RA-GRS
  EOF
  default = "LRS"
}
