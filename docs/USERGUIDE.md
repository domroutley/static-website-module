# User Guide

Basic usage overview for implementing the module.</br>
For a more technical documentation see [the wiki](./https://github.com/domroutley/static-website-module/wiki).

## Step-by-step how to implement

1. [Register an Azure account](https://azure.microsoft.com/en-gb/free/) is you do not already have one.

1. [Install the azure cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli), and run `az login`. This will allow you to run `az` commands as well as allowing Terraform to authenticate with Azure.

1. Create a resource group, storage account, and storage container in Azure for the remote Terraform statefile.

    You can either do this via the [Azure Portal](https://portal.azure.com), or through the CLI with the following commands:

    ```bash
    az group create -n [resource group name] -l [location, e.g uksouth]

    az storage account create -n [storage account name] -g [resource group name] -l [location] --sku standard_LRS

    az storage container create -n [container name] --account-name [storage account name]
    ```

1. Create a `main.tf` (or whatever name you like) file that looks like the following:

    ```terraform
    module "website" {
      source = "github.com/domroutley/website-infrastructure"
      # For required and optional arguments, see the wiki at https://github.com/domroutley/static-website-module/wiki
    }

    terraform {
      backend "azurerm" {
        resource_group_name  = "[the resource group you created in the last step]"
        storage_account_name = "[the storage account you created in the last step]"
        container_name       = "[the container you created in the last step]"
        key                  = "tfstate"
      }
    }

    provider "azurerm" {
      features {}
    }
    ```

1. [Install Terraform](https://www.terraform.io/downloads.html), you will need at least version 0.13.0

1. Run `terraform init` to initilise Terraform and create the remote statefile.

1. Run `terraform plan` to see what will happen when Terrafrom is applied.

1. Run `terraform apply` and then approve the changes, Terrafrom will now deploy the infrastructure.

    1. If you want to change the infrastructure you can edit the files and run `terraform plan` and `terraform apply` again to change whats in Azure.

    1. If you want to remove the infrastructure compleatly you can run `terraform destroy`

1. You can now upload files to your new storage account manually or through the CLI, the storage account will have an auto-created container called `$web` for you to put files into that will be served when the endpoint is hit.

## How to add a custom domain
The [Azurerm Terraform provider](https://www.terraform.io/docs/providers/azurerm/index.html) does not currently support adding a custom domain to a CDN. But you can do it via the CLI.

1. Setup a CNAME record from your domain name provider to your endpoint.

1. Run

    `az cdn custom-domain create -g website-rg --endpoint-name [your endpoint name] --profile-name website-cdn -n [arbitrary name] --hostname [your.custom.domain.name]`

    If you have changed the CDN profile name or resource group name in the Terraform code you will also need to change it here.

    If there are major changes made to the CDN profile/endpoint by Terraform after this is ran then the custom domain will be deleted, as it is not tracked by the Terraform statefile.

1. (Optional) (Although why would you not) Enable https on your custom domain by also running the command:

    `az cdn custom-domain enable-https -g website-rg --profile-name website-cdn --endpoint-name yourendpointname -n [the arbitrary name of your custom domain entered in the last command] --min-tls-version 1.2`
