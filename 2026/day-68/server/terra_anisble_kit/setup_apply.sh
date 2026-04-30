khalid@Khalid-laptop:~/day-61/teraform-basics/terra-scripts$ cat setup_apply_and_connect.sh
#!/bin/bash

set -e


KEY_NAME="terra-automate-key"

echo "Cleaning old Terraform state..."
rm -rf .terraform terraform.tfstate terraform.tfstate.backup 2>/dev/null || true

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
