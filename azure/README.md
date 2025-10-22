## Azure Databricks + ADLS (Terraform)

Provision an Azure Databricks workspace with an associated ADLS Gen2 storage account and filesystem, then access both locally via CLI.

### Prerequisites

- Terraform >= 1.6
- Azure CLI (`az`) logged into the right subscription
- Databricks CLI v0.206.0 or newer

### Setup

1) Login to Azure and select your subscription:

```bash
az login
az account set --subscription "<SUBSCRIPTION_NAME_OR_ID>"
```

2) Configure variables (copy example):

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars as needed (project_name must be short and lowercase-friendly)
```

3) Initialize, plan, and apply:

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

When finished, note the outputs for the workspace URL and resource IDs.

### Databricks CLI authentication (AAD)

Use Azure AD to authenticate; no PAT needed.

```bash
# Create a profile named 'default' using the Azure Resource ID from outputs
databricks auth login \
  --profile default \
  --azure-resource-id "$(terraform output -raw databricks_workspace_resource_id)"

# Verify the profile and workspace access
databricks auth profiles
databricks workspace list --profile default /
```

Alternatively, you can login using the workspace URL from outputs:

```bash
databricks auth login \
  --profile default \
  --host "https://$(terraform output -raw databricks_workspace_url)"
```

> Tip: If you see auth issues, ensure `az login` succeeded for the same tenant/subscription.

### Access ADLS Gen2 with Azure CLI

You can interact with the filesystem using your Azure login (no keys required):

```bash
SA_NAME=$(terraform output -raw storage_account_name)
FS_NAME=$(terraform output -raw storage_filesystem_name)

# List filesystems (containers)
az storage fs list --account-name "$SA_NAME" --auth-mode login -o table

# Create a directory and upload a file
az storage fs directory create --account-name "$SA_NAME" --file-system "$FS_NAME" --name sample --auth-mode login
echo "hello" > /tmp/hello.txt
az storage fs file upload --account-name "$SA_NAME" --file-system "$FS_NAME" --path sample/hello.txt --source /tmp/hello.txt --auth-mode login

# List files
az storage fs file list --account-name "$SA_NAME" --file-system "$FS_NAME" --path sample --auth-mode login -o table
```

### Clean up

```bash
terraform destroy -auto-approve
```

### Notes

- The storage account name is auto-generated from `project_name` with a random suffix to satisfy Azure naming rules.
- The Databricks workspace is created with public network access enabled by default. You can change `public_network_access_enabled` to `false` and integrate with a VNet if needed.
- This configuration does not create Databricks resources (clusters, jobs) and does not mint PATs. Prefer AAD auth in the CLI.


