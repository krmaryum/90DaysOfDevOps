# Ansible Inventory Setup with Terraform

## Overview
This guide explains how to:
- Configure Ansible (ansible.cfg)
- Generate dynamic inventory from Terraform outputs

---

## Step 1: Create inventory file

Create file:
```bash
vim inventory.ini
```
## Step 2: Add your servers

Use your latest IPs:

```INI
[ubuntu]
worker-ubuntu ansible_host=18.222.187.79 ansible_user=ubuntu

[redhat]
worker-redhat ansible_host=3.138.191.42 ansible_user=ec2-user

[amazon]
worker-amazon ansible_host=3.139.89.200 ansible_user=ec2-user
```

## Explanation

| Part            | Meaning    |
| --------------- | ---------- |
| `[ubuntu]`      | group name |
| `worker-ubuntu` | alias      |
| `ansible_host`  | public IP  |
| `ansible_user`  | SSH user   |

### Step 3: Test connection

Run:
```bash
ansible all -i inventory.ini -m ping --private-key terra-automate-key
```
### Expected output
```text
worker-ubuntu | SUCCESS
worker-redhat | SUCCESS
worker-amazon | SUCCESS
```
### If it fails

Run this once:
```bash
chmod 400 terra-automate-key
```

### Step 4: Add global config (cleaner)

Create:
```bash
vim ansible.cfg
```

Add:
```INI
[defaults]
inventory = inventory.ini
private_key_file = terra-automate-key
host_key_checking = False
```

### Now you can run:
```bash
ansible all -m ping
```
(no need for -i or --private-key)

### Step 5: Group-based execution

Run only Ubuntu:
```bash
ansible ubuntu -m ping
```

Run only RedHat:

```bash
ansible redhat -m ping
```

## Pro Tip (important)

Your IPs change after stop/start.

So either:

- update inventory manually ❌
- OR generate inventory from Terraform (next level) 🔥
---

## 1. Ansible Configuration File

### Location
Create ansible.cfg in your project root:

~/day-68/infra-provisioning/terraform

### Create file
vim ansible.cfg

### Add content
[defaults]
inventory = inventory.ini
private_key_file = terra-automate-key
host_key_checking = False

### Why here?

Ansible searches config in this order:

1. Current directory ✅ (best for projects)
2. Home directory (`~/.ansible.cfg`)
3. System (`/etc/ansible/ansible.cfg`)

👉 So keeping it in your project folder = portable + clean

### Now you can run:
```bash
ansible all -m ping
```

(no need for `-i` or `--private-key`)
---

## 2. Terraform Output for Inventory

Add this block in ec2.tf:

output "ansible_inventory" {
  value = {
    for name, instance in aws_instance.my_instance :
    name => {
      ip   = instance.public_ip
      user = var.instances[name].user
      os   = var.instances[name].os_family
    }
  }
}

---

## 3. Generate Inventory File

### Create script
vim generate_inventory.sh

### Script content
#!/bin/bash

terraform output -json ansible_inventory > temp.json

echo "[ubuntu]" > inventory.ini
jq -r 'to_entries[] | select(.value.os=="ubuntu") | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' temp.json >> inventory.ini

echo "" >> inventory.ini
echo "[redhat]" >> inventory.ini
jq -r 'to_entries[] | select(.value.os=="redhat") | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' temp.json >> inventory.ini

echo "" >> inventory.ini
echo "[amazon]" >> inventory.ini
jq -r 'to_entries[] | select(.value.os=="amazon") | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' temp.json >> inventory.ini

rm temp.json

echo "Inventory generated successfully!"

---

## 4. Make Script Executable

chmod +x generate_inventory.sh

---

## 5. Run Script

./generate_inventory.sh

---

## 6. Test Inventory

ansible all -m ping

---

## 7. Workflow

terraform apply
terraform refresh
./generate_inventory.sh
ansible all -m ping

---

## Notes

- Inventory updates automatically after instance restart
- Public IPs may change after stop/start
- Always run script after Terraform changes

---

## Summary

Apply infra:
terraform apply

Refresh state:
terraform refresh

Generate inventory:
./generate_inventory.sh

Test Ansible:
ansible all -m ping
