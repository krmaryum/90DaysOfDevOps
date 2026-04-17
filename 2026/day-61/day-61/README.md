# Terraform Automation Project (Day 61)

This project contains Terraform configuration and automation scripts to:

- Generate SSH keys
- Provision AWS infrastructure (EC2, S3, etc.)
- Automate Terraform workflow
- Connect to EC2 instances

---

## 📁 Project Structure

```
day-61/
├── *.tf
├── terra-automate-key
├── terra-automate-key.pub
├── setup_apply_and_connect.sh
├── setup_apply_and_connect.ps1
├── README.md
```

---

## 🚀 Features

- Automated SSH key creation
- Terraform init, validate, plan, apply
- EC2 public IP output
- Auto SSH connection
- Cross-platform support

---

## ⚙️ Prerequisites

- Terraform installed
- AWS CLI configured
- SSH installed

---

## 🐧 Linux Usage

```bash
chmod +x setup_apply_and_connect.sh
./setup_apply_and_connect.sh
```

---

## 🪟 Windows Usage

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup_apply_and_connect.ps1
```

---

## 🔑 SSH Key

Generated automatically:

terra-automate-key  
terra-automate-key.pub  

Use in Terraform:

public_key = file("terra-automate-key.pub")

---

## 🌐 Terraform Output

Add:

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

---

## 🔌 Connect to EC2

Linux:
ssh -i terra-automate-key ubuntu@<PUBLIC_IP>

Windows:
ssh -i .\terra-automate-key ubuntu@<PUBLIC_IP>

---

## 🔐 Security

Add to .gitignore:

terra-automate-key
*.tfstate
*.tfstate.backup

```bash
echo -e "terra-automate-key\n*.tfstate\n*.tfstate.backup" >> .gitignore
```

---

## 🔁 Terraform Workflow

terraform init
terraform validate
terraform plan
terraform apply

---

## 👨‍💻 Author

Khalid
