#!/bin/bash

set -e

KEY_NAME="terra-automate-key"

ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"

terraform init
terraform validate
terraform plan
terraform apply -auto-approve

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
