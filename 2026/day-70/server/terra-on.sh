#!/bin/bash
set -e

terraform apply -var-file="running.tfvars"

echo "Refreshing Terraform state..."
terraform refresh

echo "Generating inventory..."
./generate_inventory.sh

echo "Testing Ansible connectivity..."
ansible all -m ping
