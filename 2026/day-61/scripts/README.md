# Terraform Automation Scripts

This repository contains automation scripts for:
- SSH key generation
- Terraform execution (init, validate, plan, apply)
- EC2 connection

---

## Scripts Overview

| Script Name | Platform | Description |
|------------|----------|------------|
| create_key.sh | Linux | Create SSH key in current directory |
| apply.sh | Linux | Run Terraform workflow |
| setup_and_apply.sh | Linux | Create key + run Terraform |
| setup_apply_and_connect.sh | Linux | Full automation + SSH connection |
| setup_apply_and_connect.ps1 | Windows | Full automation + SSH connection |

---

## Quick Start

### Linux (Bash)

```bash
chmod +x setup_apply_and_connect.sh
./setup_apply_and_connect.sh
```

---

### Windows (PowerShell)

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup_apply_and_connect.ps1
```

---

## SSH Key

Scripts create:

terra-automate-key  
terra-automate-key.pub  

Use in Terraform:

public_key = file("terra-automate-key.pub")

---

## Terraform Output (Required)

Add:

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

---

## Connect to EC2

Linux:
ssh -i terra-automate-key ubuntu@<PUBLIC_IP>

Windows:
ssh -i .\terra-automate-key ubuntu@<PUBLIC_IP>

---

## Security

Add to .gitignore:

terra-automate-key
*.tfstate
*.tfstate.backup

---

## Terraform Workflow

terraform init
terraform validate
terraform plan
terraform apply

---

## Author

Khalid
