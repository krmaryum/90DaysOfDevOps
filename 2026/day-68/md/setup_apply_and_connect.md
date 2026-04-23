# Script Explanation: setup_apply_and_connect.sh

## Overview

This script automates the process of setting up SSH keys and deploying infrastructure using Terraform. It reduces manual effort and ensures a consistent and repeatable workflow.

---

## Step-by-Step Explanation

### 1. Script Initialization

```bash
#!/bin/bash
set -e
```

- Uses bash to execute the script
- Stops execution if any command fails

---

### 2. Define SSH Key Name

```bash
KEY_NAME="terra-automate-key"
```

- Stores the SSH key name for reuse

---

### 3. Clean Old Terraform State

```bash
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
```

- Removes previous Terraform files
- Ensures a fresh deployment

---

### 4. SSH Key Setup

#### Check if key exists

```bash
if [ -f "$KEY_NAME" ] || [ -f "$KEY_NAME.pub" ];
```

- Checks for existing key files

#### Prompt for overwrite

```bash
read -p "Do you want to overwrite it? (yes/no): " confirm
```

- Prevents accidental deletion

#### Remove old key (if confirmed)

```bash
rm -f "$KEY_NAME" "$KEY_NAME.pub"
```

#### Generate new key

```bash
ssh-keygen -t ed25519 -f "./$KEY_NAME" -N "" -C "terraform-key"
```

- Creates a secure SSH key pair

#### Display key paths

```bash
echo "Private key: $(pwd)/$KEY_NAME"
echo "Public key:  $(pwd)/$KEY_NAME.pub"
```

---

### 5. Terraform Execution

#### Initialize Terraform

```bash
terraform init
```

- Prepares working directory and downloads providers

#### Validate configuration

```bash
terraform validate
```

- Checks for syntax errors

#### Plan infrastructure

```bash
terraform plan
```

- Shows what changes will be made

#### Apply configuration

```bash
terraform apply -auto-approve
```

- Creates infrastructure automatically

---

## What This Script Achieves

- Cleans previous Terraform setup
- Generates SSH keys if needed
- Initializes and validates Terraform
- Deploys infrastructure automatically

---

## Summary

This script automates the full lifecycle of infrastructure provisioning using Terraform, making the process faster, reliable, and repeatable.

---

## One-Line Explanation

This script automates SSH key creation and Terraform deployment for quick and consistent infrastructure setup.
