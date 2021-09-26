: '
az login
az login --use-device-code
az logout
az account clear
az account show --output jsonc
az account set --subscription "SZYMONOS-MSDN"
Get-ChildItem .terraform/*, *.tfstate*, *.lock.hcl, *.tfplan | Remove-Item -Recurse -Force
rm -fr .terraform*; rm -f *.tfstate*; rm -f *.lock.hcl; rm -f *.tfplan*
'
cd "$SWD/.tmp"
cd "$SWD/backend"
cd "$SWD/machine-learning-service"

terraform init
terraform init -upgrade
terraform init -reconfigure

# *manage workspaces
terraform workspace new Development
terraform workspace new Production
terraform workspace show
terraform workspace list
terraform workspace select Development
terraform workspace select Production

# *validate configuration
terraform validate

# *plan and then apply
terraform plan -out "terraform.tfplan"
terraform apply "terraform.tfplan"
terraform apply -refresh-only
# use custom tfvars
terraform plan --var-file=terraform.tfvars -out "terraform.tfplan"
terraform apply "terraform.tfplan"
# plan and apply at once
terraform refresh

# *draw dependency plan
terraform graph | dot -Tsvg > graph.svg

# *manage state
terraform state list
terraform state pull
terraform state show azurerm_storage_account.default
terraform state rm azurerm_storage_account.default

# *import resources
terraform import azurerm_resource_group.default /subscriptions/026b5895-980a-4fdb-a8fd-f59fe3e04231/resourceGroups/RG-Infra-WEU

# !destroy all resources
terraform destroy
terraform destroy --var-file=terraform.tfvars

# *test in terraform console
terraform console
