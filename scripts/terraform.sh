: '
az login
az logout
az account clear
az account show --output jsonc
az account set --subscription "SZYMONOS-MSDN"
rm -fr .terraform* && rm -f *.tfstate*
'
cd "$SWD/terraform"

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
terraform plan --var-file=terraform.tfvars
terraform apply --var-file=terraform.tfvars
# plan and apply at once
terraform refresh

# *draw dependency plan
terraform graph | dot -Tsvg > graph.svg

# *manage state
terraform state list
terraform state pull
terraform state show azurerm_app_service.web_app
terraform state rm azurerm_app_service.web_app

# *import resources
terraform import azurerm_resource_group.devops /subscriptions/026b5895-980a-4fdb-a8fd-f59fe3e04231/resourceGroups/RG-Infra-WEU

# !destroy all resources
terraform destroy
terraform destroy --var-file=terraform.tfvars
