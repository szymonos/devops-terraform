# Introduction

Terraform repository for common Azure resources.

## Getting Started

1. Clone repository and open in VSCode.
2. Install Terraform via choco:\
   `choco install -y terraform`

## Build and Test

Terraform main commands

- init - prepare your working directory for other commands
- validate - check whether the configuration is valid
- plan - show changes required by the current configuration
- apply - create or update infrastructure
- destroy - destroy previously-created infrastructure

## Repo folders

- **BackEnd**\
  Definition of the storage account used for Terraform backend, which defines where and how operations are performed, where state snapshots are stored, etc.
- **CommonServices**\
  Definition of common services, that are not stored in application specific repos, like Key Vault, App Configuration Service, SQL Servers, etc.

## TerraForm Azure Provider documentation

[Docs overview | hashicorp/**azurerm** | Terraform Registry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)\
[Docs overview | hashicorp/**azuread** | Terraform Registry](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs)
