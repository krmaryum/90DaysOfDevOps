#!/bin/bash

set -e

KEY_NAME="terra-automate-key"

echo "===== STEP 1: SSH Key Setup ====="

# Check if key exists
if [ -f "$KEY_NAME" ] || [ -f "$KEY_NAME.pub" ]; then
  echo "Key already exists."
  read -p "Do you want to overwrite it? (yes/no): " confirm

  if [ "$confirm" != "yes" ]; then
    echo "Skipping key creation."
  else
    rm -f "$KEY_NAME" "$KEY_NAME.pub"
    echo "Old key removed."
  fi
fi

# Create key if not exists
if [ ! -f "$KEY_NAME" ]; then
  echo "Creating SSH key..."
  ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"
  echo "SSH key created."
fi

echo ""
echo "Private key: $(pwd)/$KEY_NAME"
echo "Public key:  $(pwd)/$KEY_NAME.pub"

echo ""
echo "===== STEP 2: Terraform Execution ====="

echo "Initializing Terraform..."
terraform init

echo "Validating Terraform..."
terraform validate

echo "Planning Terraform changes..."
terraform plan

echo "Applying Terraform..."
terraform apply -auto-approve

echo ""
echo "===== DONE ====="
echo "Infrastructure created successfully."

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
