#!/bin/bash

set -e

KEY_NAME="terra-automate-key"
TF_OUTPUT_NAME="public_ip"

echo "===== STEP 1: SSH Key Setup ====="

if [ -f "$KEY_NAME" ] || [ -f "$KEY_NAME.pub" ]; then
  echo "Key already exists."
  read -p "Do you want to overwrite it? (yes/no): " confirm

  if [ "$confirm" = "yes" ]; then
    rm -f "$KEY_NAME" "$KEY_NAME.pub"
    echo "Old key removed."
  else
    echo "Skipping key creation."
  fi
fi

if [ ! -f "$KEY_NAME" ]; then
  echo "Creating SSH key..."
  ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"
  echo "SSH key created."
fi

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
echo "===== STEP 3: Fetch Public IP ====="

PUBLIC_IP=$(terraform output -raw public_ip 2>/dev/null || true)

if [ -z "$PUBLIC_IP" ]; then
  echo "Could not read Terraform output named 'public_ip'."
  echo "Add this to your Terraform code:"
  echo ""
  echo 'output "public_ip" {'
  echo '  value = aws_instance.my_instance.public_ip'
  echo '}'
  exit 0
fi

echo "EC2 Public IP: $PUBLIC_IP"

echo ""
echo "SSH command:"
echo "ssh -i ./$KEY_NAME ubuntu@$PUBLIC_IP"

echo ""
read -p "Do you want to connect now? (yes/no): " connect_now

if [ "$connect_now" = "yes" ]; then
  ssh -i "./$KEY_NAME" ubuntu@"$PUBLIC_IP"
else
  echo "Connection skipped."
fi
```

### Add this to your Terraform file

This script expects a Terraform output named public_ip:
```hcl
output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
