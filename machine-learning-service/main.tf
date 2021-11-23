locals {
  compute_cluster_name    = "default"
  name_base               = "${lower(substr(replace(var.resource_name, "-", ""), 0, 16))}${random_string.random.id}"
  app_insights_name       = "${local.name_base}ai"
  container_registry_name = "${local.name_base}cr"
  key_vault_name          = "${local.name_base}kv"
  storage_account_name    = "${local.name_base}sa"
}

data "azurerm_subscription" "current" {
  subscription_id = var.subscription_id
}

data "azurerm_key_vault" "current" {
  count               = var.existing_key_vault ? 1 : 0
  name                = var.key_vault_name
  resource_group_name = var.key_vault_rg
}

data "azurerm_container_registry" "current" {
  count               = var.existing_container_registry ? 1 : 0
  name                = var.container_registry_name
  resource_group_name = var.container_registry_rg
}

data "azurerm_kubernetes_cluster" "current" {
  count               = var.existing_aks ? 1 : 0
  name                = var.aks_name
  resource_group_name = var.aks_rg
}

resource "random_string" "random" {
  length      = 6
  special     = false
  upper       = false
  min_lower   = 2
  min_numeric = 2
}

resource "azurerm_resource_group" "default" {
  name     = var.resource_group
  location = var.location

  tags = var.resource_tags
}

resource "azurerm_application_insights" "default" {
  name                = local.app_insights_name
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  application_type    = "web"

  tags = var.resource_tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_account" "default" {
  name                     = local.storage_account_name
  location                 = var.location
  resource_group_name      = azurerm_resource_group.default.name
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  access_tier              = var.storage_account_access_tier
  min_tls_version          = "TLS1_2"
  tags                     = var.resource_tags
}

resource "azurerm_machine_learning_workspace" "default" {
  name                     = var.resource_name
  location                 = azurerm_resource_group.default.location
  resource_group_name      = azurerm_resource_group.default.name
  application_insights_id  = azurerm_application_insights.default.id
  image_build_compute_name = local.compute_cluster_name
  key_vault_id             = data.azurerm_key_vault.current[0].id
  storage_account_id       = azurerm_storage_account.default.id
  container_registry_id    = data.azurerm_container_registry.current[0].id

  tags = var.resource_tags

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

resource "azurerm_machine_learning_compute_cluster" "default" {
  count = var.enable_default_compute ? 1 : 0

  name                          = local.compute_cluster_name
  location                      = azurerm_resource_group.default.location
  vm_priority                   = var.compute_priority
  vm_size                       = var.compute_size
  machine_learning_workspace_id = azurerm_machine_learning_workspace.default.id

  tags = var.resource_tags

  scale_settings {
    min_node_count                       = var.min_node_count
    max_node_count                       = var.max_node_count
    scale_down_nodes_after_idle_duration = var.default_compute_idle_seconds
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_machine_learning_inference_cluster" "default" {
  count = var.existing_aks ? 1 : 0

  name                          = var.aks_name
  location                      = azurerm_resource_group.default.location
  cluster_purpose               = var.inference_purpose
  kubernetes_cluster_id         = data.azurerm_kubernetes_cluster.current[0].id
  machine_learning_workspace_id = azurerm_machine_learning_workspace.default.id

  tags = var.resource_tags
}
