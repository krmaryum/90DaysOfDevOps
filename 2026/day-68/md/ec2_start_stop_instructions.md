# EC2 Start and Stop Instructions (Terraform)

## Overview
This guide explains how to START and STOP EC2 instances using Terraform in this project.

---

## Start EC2 Instances

Step 1: Create `terraform.tfvars`
```bash
vim terraform.tfvars
```

Step 2: Set instance_state to running
instance_state = "running"

OR

```bash
echo "instance_state = "running"" > terraform.tfvars
```

Step 3: Apply Terraform
```bash
terraform apply
```

Step 4: Verify public IPs
terraform output public_ips

---

## Stop EC2 Instances

Step 1: Create `terraform.tfvars`
```bash
vim terraform.tfvars
```

Step 2: Set instance_state to stopped
instance_state = "stopped"

OR

```bash
echo "instance_state = "stopped"" > terraform.tfvars
```

Step 3: Apply Terraform
```bash
terraform apply
```
```text
Apply complete! Resources: 0 added, 3 changed, 0 destroyed.

Outputs:

public_ips = {
  "worker-amazon" = ""
  "worker-redhat" = ""
  "worker-ubuntu" = ""
}
```
### To get PUb IPs

Run this:
```bash
terraform refresh
```
```text
Outputs:

public_ips = {
  "worker-amazon" = "3.139.89.200"
  "worker-redhat" = "3.138.191.42"
  "worker-ubuntu" = "18.222.187.79"
}
```
---



---

## Important Notes

- Do NOT stop/start instances from AWS Console
- Always use Terraform to maintain state consistency
- Public IPs may change after stopping and starting instances
- Run terraform refresh if outputs are not updated

---

## Summary

Start EC2:
terraform apply (instance_state=running)

Stop EC2:
terraform apply (instance_state=stopped)

Get IPs:
terraform output public_ips

---

## Tip

For quick control:
- Edit terraform.tfvars
- Run terraform apply

This ensures clean and consistent infrastructure management.
