# Terraform: Service Status API

This configuration looks up an existing Azure resource group and manages a Linux App Service plan and Linux Web App for the API. It does not deploy the App Service resources until `terraform apply` is run. The lab's previously provisioned App Service resources have been torn down; this directory describes reproducible configuration, not currently live Azure resources.

Create the resource group `rg-service-status-lab` separately in the desired region before planning. Terraform reads its name and location; it will not create or delete the group. This allows an apply identity to be scoped to that group.

The plan uses the Free (`F1`) App Service tier to keep the lab cost-conscious. It has significant limitations and availability can vary by region and subscription. Always On is disabled because it isn't supported by this tier, and FTP/WebDeploy basic publishing authentication is disabled. Review the current Azure pricing and the plan shown by Terraform before creating resources.

## Inputs

Create a local `terraform.tfvars` file in this directory with values for:

```hcl
subscription_id = "your-subscription-id"
web_app_name    = "a-globally-unique-lowercase-name"
```

Local `.tfvars` files and Terraform state are ignored by Git. The subscription ID is not a password, but credentials and secrets must never be placed in this file or committed.

## Remote state

`backend.tf` configures Terraform to store state in the private Azure Blob container `tfstate`, using the blob name `service-status-lab.tfstate`. The storage account and container are separate from the App Service resources and must exist before backend initialization.

For local work, sign in with `az login` and use an identity that has **Storage Blob Data Contributor** access to the state container. The backend uses Microsoft Entra ID through Azure CLI; do not put storage keys or tokens in the configuration. Terraform state can contain sensitive resource details, so keep the container private and never commit state files. The repository does not provide current state contents or a resource inventory after teardown.

The validation job runs `terraform init -backend=false`, while the `Plan` and `Apply` Azure Pipelines steps run `terraform init -reconfigure` and use this remote backend. The `sc-terraform-plan` and `sc-terraform-apply` service connections, plus scoped Blob data access, must be configured before those pipeline stages can use remote state.

## Validate without deploying

From this directory:

```powershell
az login
terraform fmt -check -recursive
terraform init -input=false -lockfile=readonly
terraform validate
```

Planning requires Azure authentication, the target subscription, the existing resource group, the remote state backend, and a globally unique Web App name. The app resources use the existing resource group's region. Review the full plan and cost implications before any apply. The lab pipeline validates on all configured branches and, on `main`, can plan and apply only through the configured approvals. No current Azure resource names beyond the configuration values, live endpoint, IDs, or deployment results are asserted by this README.
