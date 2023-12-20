# coreInfra

This is a wizzard to help install a basic Cloud with GCP Provider.


#### step 1 - Create key for Terraform Cloud

Terraform Cloud use User or Team API Key to manage Workspaces. To make this easly create a file name credenticials.tfrc.json with this format below:

        {
            "credentials": {
                "app.terraform.io": {
                    "token": "xxxxxxxxxxxx.yyyyyyyy.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
                }
            }
        }


#### step 2 - Create key_file for Cloud Provider

Cloud provider needs authentication method, this IaC use .json file, create a service account, export json and save in this folder with name

    key_name_you_want.json

This key will be declared again in next step in `google_application_credentials`
The init.sh will copy this content to terraform/credentials.json used in `credentials = file(var.credentials)` in main.tf


#### step 3 - Create .env

Your Terraform needs some information to build something in the Cloud, use .env to progate data to terraform.tfvars

        tf_token = "xxxxxxxxxxxx.yyyyyyyy.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"
        google_application_credentials = "key_name_you_want.json"
        tfvars_organization_name = "organization_name"
        tfvars_workspace_name = "workspace_name"
        tfvars_project_id = "project_id"
        tfvars_region = "region_you_want"
        tfvars_zone = "zone_you_want"
        tfvars_credentials = "credentials.json"


#### step 4 - Run

To run this script it is very easly, call make

        make

This will call hashicorp/terraform image and run with your information, prompt will run: fmt, init and plan.
If you like the answes, you can copy docker run and add commad apply