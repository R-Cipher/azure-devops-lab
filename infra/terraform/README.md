# Terraform: Service Status API

This configuration describes an Azure resource group, a Linux App Service plan, and a Linux Web App for the API. It does not deploy anything until `terraform apply` is run.

The plan uses the Free (`F1`) App Service tier to keep the lab cost-conscious. It has significant limitations and availability can vary by region and subscription. Always On is disabled because it isn't supported by this tier, and FTP/WebDeploy basic publishing authentication is disabled. Review the current Azure pricing and the plan shown by Terraform before creating resources.

## Inputs

Create a local `terraform.tfvars` file in this directory with values for:

```hcl
subscription_id = "your-subscription-id"
location        = "your-azure-region"
web_app_name    = "a-globally-unique-lowercase-name"
```

Local `.tfvars` files and Terraform state are ignored by Git. The subscription ID is not a password, but credentials and secrets must never be placed in this file or committed.

## Validate without deploying

From this directory:

```powershell
terraform init
terraform fmt -check
terraform validate
```

Planning requires Azure authentication and values for the target subscription, region, and globally unique Web App name. Review the full plan and cost implications before any apply. The lab pipeline will validate the configuration; it will not apply infrastructure automatically.
