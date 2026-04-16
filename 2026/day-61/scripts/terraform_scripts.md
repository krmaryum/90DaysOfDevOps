# Terraform Automation Scripts

## Script Table

| Script Name | Description | Link |
|------------|------------|------|
| create_key.sh | Create SSH key in current folder | [Go to Script](#1-bash-script-create_keysh) |
| apply.sh | Run Terraform (init → validate → plan → apply) | [Go to Script](#2-bash-script-applysh) |
| setup_and_apply.sh | Create key + run Terraform | [Go to Script](#3-bash-script-setup_and_applysh) |
| setup_terraform.sh | Create key with overwrite protection | [Go to Script](#-script-setup_terraformsh) |
| setup_apply_and_connect.sh | Full automation + SSH connect | [Go to Script](#absolutely--heres-a-single-script-that-does) |
| setup_apply_and_connect.ps1 | Windows PowerShell version | [Go to Script](#heres-the-windows-powershell-version-of-the-combined-script-that-does) |

## 1. Bash Script: create_key.sh

```bash
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
```

---

## 2. Bash Script: apply.sh

```bash
#!/bin/bash

set -e

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## 3. Bash Script: setup_and_apply.sh

```bash
#!/bin/bash

set -e

KEY_NAME="terra-automate-key"

ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"

terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

---

## 4. PowerShell Script: setup_apply_and_connect.ps1

```powershell
$ErrorActionPreference = "Stop"

$keyName = "terra-automate-key"

ssh-keygen -t ed25519 -f ".\$keyName" -C "terraform-key"

terraform init
terraform validate
terraform plan
terraform apply -auto-approve

$publicIp = (terraform output -raw public_ip)

ssh -i ".\$keyName" "ubuntu@$publicIp"
```

---

## Notes

- Do not upload private key (`terra-automate-key`) to GitHub
- Add to .gitignore:
```
terra-automate-key
*.tfstate
*.tfstate.backup
```

## 5. simple bash script that will create an SSH key named `terra-automate-key` in the current (running) folder:

## 🔑 Script: `create_key.sh`
```bash
#!/bin/bash

set -e

echo "Creating SSH key in current directory..."

# Generate SSH key
ssh-keygen -t ed25519 -f ./terra-automate-key -N "" -C "terraform-key"

echo "SSH key created successfully!"

echo "Private key: $(pwd)/terra-automate-key"
echo "Public key:  $(pwd)/terra-automate-key.pub"
```
### Output

It will create:
```text
terra-automate-key       ← private key
terra-automate-key.pub   ← public key
```

---

## 🔧 Script: `setup_terraform.sh`
This script will:
- Create SSH key (terra-automate-key)
- Prevent overwrite unless confirmed
- Show paths for Terraform use
```bash
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
```
### 🔐 Important

Add to .gitignore:
```bash
terra-automate-key
*.tfstate
*.tfstate.backup
```
---

### Terraform apply script

Save as `apply.sh`

```bash
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
```

---

## Combined Version
### Script: `setup_and_apply.sh`

```bash
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
```
### How to use
```bash
chmod +x setup_and_apply.sh
./setup_and_apply.sh
```

---

## Absolutely — here’s a single script that does:

1. creates the SSH key if needed
2. runs Terraform (init, validate, plan, apply)
3. prints the EC2 public IP
4. shows the SSH command to connect
5. optionally auto-connects to the instance

`setup_apply_and_connect.sh`

```bash
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
```

### How to use
```bash
chmod +x setup_apply_and_connect.sh
./setup_apply_and_connect.sh
```

### Important

Your Terraform key line should still be:
```hcl
public_key = file("terra-automate-key.pub")
```
And add this to `.gitignore`:
```bash
terra-automate-key
*.tfstate
*.tfstate.backup
```
### Notes
- `ubuntu@$PUBLIC_IP` is correct for Ubuntu AMIs
- if your AMI is Amazon Linux, use `ec2-user@$PUBLIC_IP` instead

---

### Here’s the Windows PowerShell version of the combined script that does:

1. creates the SSH key as terra-automate-key
2. runs terraform init, validate, plan, and apply
3. reads the EC2 public IP from Terraform output
4. shows the SSH command
5. optionally connects

`setup_apply_and_connect.ps1`
```PowerShell
$ErrorActionPreference = "Stop"

$keyName = "terra-automate-key"
$publicKey = "$keyName.pub"

Write-Host "===== STEP 1: SSH Key Setup ====="

if ((Test-Path $keyName) -or (Test-Path $publicKey)) {
    Write-Host "Key already exists."
    $confirm = Read-Host "Do you want to overwrite it? (yes/no)"

    if ($confirm -eq "yes") {
        if (Test-Path $keyName) { Remove-Item $keyName -Force }
        if (Test-Path $publicKey) { Remove-Item $publicKey -Force }
        Write-Host "Old key removed."
    }
    else {
        Write-Host "Skipping key creation."
    }
}

if (-not (Test-Path $keyName)) {
    Write-Host "Creating SSH key..."
    ssh-keygen -t ed25519 -f ".\$keyName" -N '""' -C "terraform-key"
    Write-Host "SSH key created."
}

Write-Host "Private key: $(Join-Path (Get-Location) $keyName)"
Write-Host "Public key:  $(Join-Path (Get-Location) $publicKey)"

Write-Host ""
Write-Host "===== STEP 2: Terraform Execution ====="

Write-Host "Initializing Terraform..."
terraform init

Write-Host "Validating Terraform..."
terraform validate

Write-Host "Planning Terraform changes..."
terraform plan

Write-Host "Applying Terraform..."
terraform apply -auto-approve

Write-Host ""
Write-Host "===== STEP 3: Fetch Public IP ====="

$publicIp = ""
try {
    $publicIp = (terraform output -raw public_ip).Trim()
}
catch {
    $publicIp = ""
}

if ([string]::IsNullOrWhiteSpace($publicIp)) {
    Write-Host "Could not read Terraform output named 'public_ip'."
    Write-Host "Add this to your Terraform code:"
    Write-Host ""
    Write-Host 'output "public_ip" {'
    Write-Host '  value = aws_instance.my_instance.public_ip'
    Write-Host '}'
    exit
}

Write-Host "EC2 Public IP: $publicIp"
Write-Host ""
Write-Host "SSH command:"
Write-Host "ssh -i .\$keyName ubuntu@$publicIp"
Write-Host ""

$connectNow = Read-Host "Do you want to connect now? (yes/no)"
if ($connectNow -eq "yes") {
    ssh -i ".\$keyName" "ubuntu@$publicIp"
}
else {
    Write-Host "Connection skipped."
}
```
