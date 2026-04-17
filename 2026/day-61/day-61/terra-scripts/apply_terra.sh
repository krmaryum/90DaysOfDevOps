#!/bin/bash

set -e

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Terraform changes..."
terraform plan

echo "Applying Terraform..."
terraform apply -auto-approve

echo "Terraform apply completed successfully."

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
