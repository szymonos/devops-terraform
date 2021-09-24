# *VARIABLES*
variable "subscription_id" {
  type        = string
  description = "ID of the subscription where the resource will be deployed"
}

variable "location" {
  type        = string
  description = "Location for the resource"
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group where the resource(s) will be deployed"
}

variable "storage_account" {
  type        = string
  description = "Name of the storage account"
}

variable "container" {
  type        = string
  description = "Name of the blob container"
}
