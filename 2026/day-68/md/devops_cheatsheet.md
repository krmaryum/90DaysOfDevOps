# DevOps Cheat Sheet: Terraform + EC2 + SSH + AWS CLI

---

# Terraform Commands

## Format files
terraform fmt

## Initialize project
terraform init

## Validate configuration
terraform validate

## Preview changes
terraform plan

## Apply (Create infrastructure)
terraform apply

## Destroy (Delete everything)
terraform destroy

## Show outputs (like public IPs)
terraform output public_ips

---

# SSH Commands

## Fix key permissions
chmod 400 terra-automate-key

## Connect to Ubuntu
ssh -i terra-automate-key ubuntu@<PUBLIC_IP>

## Connect to RedHat / Amazon Linux
ssh -i terra-automate-key ec2-user@<PUBLIC_IP>

---

# AWS CLI (Start / Stop Instances)

## Stop EC2 instance
aws ec2 stop-instances --instance-ids <INSTANCE_ID>

## Start EC2 instance
aws ec2 start-instances --instance-ids <INSTANCE_ID>

## Check instance status
aws ec2 describe-instances --instance-ids <INSTANCE_ID>

---

# Useful Tips

- Terraform is used for:
  - Creating infrastructure
  - Destroying infrastructure

- AWS CLI is used for:
  - Start / Stop / Reboot EC2

- SSH usernames:
  - Ubuntu → ubuntu
  - RedHat → ec2-user
  - Amazon Linux → ec2-user

- Private key:
  - terra-automate-key (keep safe)

---

# Workflow Summary

1. terraform init
2. terraform plan
3. terraform apply
4. terraform output public_ips
5. ssh into servers
6. (optional) ansible automation
7. terraform destroy (cleanup)

---

# Notes

- Always run Terraform from your local machine
- Do not run SSH between EC2 instances unless key is copied
- Keep .tfstate and keys secure
