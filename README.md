# Static Website Infrastructure
Infrastructure for a static hosted website in Azure.

## How to implement

1. [Register an Azure account](https://azure.microsoft.com/en-gb/free/) is you do not already have one.

1. [Install the azure cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli), and run `az login`. This will allow you to run `az` commands as well as allowing Terraform to authenticate with Azure.

1. Create a resource group, storage account, and storage container in Azure for the remote Terraform statefile.

    You can either do this via the [Azure Portal](https://portal.azure.com), or through the CLI with the following commands:

    ```bash
    az group create -n tf-states-rg -l uksouth

    az storage account create -n storageaccountname -g tf-states-rg -l uksouth --sku standard_LRS

    az storage container create -n tfstate --account-name storageaccountname
    ```

1. Clone this repository and edit the `terraform.tfvars` file to contain your own variables. Also edit the `terraform.tf` file to change the backend resource group name, storage account name, and container name to the values you used in the last step.

1. Run `terraform init` to initilise Terraform and create the remote statefile.

1. Run `terrafrom plan` to see what will happen when Terrafrom is applied.

1. Run `terraform apply` and then approve the changes, Terrafrom will now deploy the infrastructure.

    1. If you want to change the infrastructure you can edit the files and run `terraform plan` and `terraform apply` again to change whats in Azure.

    1. If you want to remove the infrastructure compleatly you can run `terrafrom destroy`

1. You can now upload files to your new storage account manually or through the CLI, the storage account will have an auto-created container called `$web` for you to put files into that will be served when the endpoint is hit.
