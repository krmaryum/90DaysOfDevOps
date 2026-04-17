#!/bin/bash

set -e

KEY_NAME="terra-automate-key"

echo "Creating SSH key in current folder..."

if [ -f "$KEY_NAME" ] || [ -f "$KEY_NAME.pub" ]; then
  echo "Key already exists in this folder."
  read -p "Overwrite existing key? (yes/no): " confirm

  if [ "$confirm" != "yes" ]; then
    echo "Key creation cancelled."
    exit 0
  fi

  rm -f "$KEY_NAME" "$KEY_NAME.pub"
fi

ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"

echo "SSH key created successfully."

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
