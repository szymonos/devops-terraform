# *VARIABLES*
variable "subscription_id" {
  type        = string
  description = "ID of the subscription where the resource will be deployed"
}

variable "resource_group" {
  type        = string
  description = "Name of the resource group where the resource(s) will be deployed"
}

variable "resource_name" {
  type        = string
  description = "Name of the resource to be deployed"
}

variable "location" {
  type        = string
  description = "Location for the resource, if empty then Resource Group location will be used"
}

variable "resource_tags" {
  type        = map(any)
  default     = {}
  description = "Tags for the resource"
}

variable "storage_account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the account kind to use for this storage account."
}

variable "storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Defines the type of replication to use for the storage account. Valid options are LRS, GRS, RAGRS."
}

variable "storage_account_access_tier" {
  type        = string
  default     = "Hot"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
}

variable "min_node_count" {
  default     = 0
  type        = number
  description = "The minimum number of nodes to use on the cluster. If not specified, defaults to 0"
}

variable "max_node_count" {
  default     = 1
  type        = number
  description = "The maximum number of nodes to use on the cluster. If not specified, defaults to 4."
}

variable "default_compute_idle_seconds" {
  default     = "PT30S"
  type        = string
  description = "Default compute idle in seconds"
}

variable "enable_default_compute" {
  default     = true
  type        = bool
  description = "Enable or disable the default compute creation , defaults to true."
}

variable "existing_key_vault" {
  type        = bool
  default     = true
  description = "Use existing key vault?"
}

variable "existing_container_registry" {
  type        = bool
  default     = true
  description = "Use existing container registry?"
}

variable "existing_aks" {
  type        = bool
  default     = true
  description = "Use existing AKS cluster?"
}

variable "key_vault_name" {
  type        = string
  description = "Name of the key vault to use, has to be in the same resource group"
}

variable "key_vault_rg" {
  type        = string
  description = "Name of the key vault resource group"
}

variable "container_registry_name" {
  type        = string
  description = "Name of the container registry to use, has to be in the same resource group"
}

variable "container_registry_rg" {
  type        = string
  description = "Name of the container registry resource group"
}

variable "aks_name" {
  type        = string
  description = "Name of the AKS cluster to use, has to be in the same resource group"
}

variable "aks_rg" {
  type        = string
  description = "Name of the AKS cluster resource group"
}

variable "inference_purpose" {
  type        = string
  description = "The purpose of the Inference Cluster"
}

variable "compute_priority" {
  type        = string
  description = "The priority of the compute cluster VM"
}

variable "compute_size" {
  type        = string
  description = "The size of the compute cluster VM"
}
