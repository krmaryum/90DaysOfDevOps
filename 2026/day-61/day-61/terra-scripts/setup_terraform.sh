# This script will:
# - Create SSH key (terra-automate-key)
# - Prevent overwrite unless confirmed
# - Show paths for Terraform use


#!/bin/bash

set -e

KEY_NAME="terra-automate-key"

echo "Starting setup..."

# Check if key already exists
if [ -f "$KEY_NAME" ]; then
  echo "Key already exists: $KEY_NAME"
  read -p "Do you want to overwrite it? (yes/no): " confirm

  if [ "$confirm" != "yes" ]; then
    echo "Skipping key creation."
  else
    rm -f $KEY_NAME $KEY_NAME.pub
    echo "Old key removed."
  fi
fi

# Create key if not exists
if [ ! -f "$KEY_NAME" ]; then
  echo "Creating SSH key..."
  ssh-keygen -t ed25519 -f ./$KEY_NAME -N "" -C "terraform-key"
  echo "SSH key created."
fi

echo ""
echo "Setup complete."
echo "Private key: $(pwd)/$KEY_NAME"
echo "Public key:  $(pwd)/$KEY_NAME.pub"

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
