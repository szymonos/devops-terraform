<#
.SYNOPSIS
Set (by mode: ON OFF) the Storage Account Firewall Rules by Public IP address. Used by Azure DevOps Build/Release agents
See here : https://github.com/terraform-providers/terraform-provider-azurerm/issues/2977
.DESCRIPTION
Using Azure CLI
.EXAMPLE
$sa = ''; $rg = ''
scripts/StorageAccountRule.ps1 -storageaccount $sa -resourcegroup $rg -mode on
.NOTES
Written by Neil McAlister - March 2020
#>
param (
    [Parameter(Mandatory = $true)]
    [string]$storageaccount,
    [Parameter(Mandatory = $true)]
    [string]$resourcegroup,
    [Parameter(Mandatory = $true)]
    [string]$mode
)
#
$ip = Invoke-RestMethod -Uri 'https://ifconfig.me/ip'
Write-Host $ip
#
if ($mode -eq 'on') {
    az storage account network-rule add --resource-group $resourcegroup --account-name $storageaccount --ip-address $ip
}
#
if ($mode -eq 'off') {
    az storage account network-rule remove --resource-group $resourcegroup --account-name $storageaccount --ip-address $ip
}
