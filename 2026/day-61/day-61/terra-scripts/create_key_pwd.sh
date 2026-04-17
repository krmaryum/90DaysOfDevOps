#!/bin/bash

set -e

echo "Creating SSH key in current directory..."

# Generate SSH key
ssh-keygen -t ed25519 -f ./terra-automate-key -N "" -C "terraform-key"

echo "SSH key created successfully!"

echo "Private key: $(pwd)/terra-automate-key"
echo "Public key:  $(pwd)/terra-automate-key.pub"

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
