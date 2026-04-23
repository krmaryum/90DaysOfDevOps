# Terraform to Ansible Inventory Script Explained

## Overview
This document explains how a Bash script converts Terraform output into an Ansible inventory file automatically.

---

## Full Script

```
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

echo "" >> inventory.ini
echo "[servers]" >> inventory.ini
jq -r 'keys[]' temp.json >> inventory.ini

echo "" >> inventory.ini
echo "[servers:vars]" >> inventory.ini
echo "ansible_python_interpreter=/usr/bin/python3" >> inventory.ini

rm temp.json

echo "Inventory generated successfully!"
```

---

## Step-by-Step Explanation

### 1. Shebang
```
#!/bin/bash
```
Tells the system to run the script using Bash.

---

### 2. Get Terraform Output
```
terraform output -json ansible_inventory > temp.json
```
- Fetches Terraform output in JSON format
- Saves it into a temporary file (`temp.json`)

---

### 3. Create Ubuntu Group
```
echo "[ubuntu]" > inventory.ini
```
- Creates/overwrites `inventory.ini`
- Adds Ubuntu group header

---

### 4. Add Ubuntu Hosts
```
jq -r 'to_entries[] | select(.value.os=="ubuntu") | "\(.key) ansible_host=\(.value.ip) ansible_user=\(.value.user)"' temp.json >> inventory.ini
```
- Reads JSON using `jq`
- Filters only Ubuntu servers
- Formats them into Ansible inventory format
- Appends to file

---

### 5. Add RedHat Group
Same logic as Ubuntu:
- Filters `os=="redhat"`
- Appends hosts

---

### 6. Add Amazon Group
Same logic:
- Filters `os=="amazon"`

---

### 7. Create Combined Group
```
echo "[servers]" >> inventory.ini
jq -r 'keys[]' temp.json >> inventory.ini
```
- Adds all hostnames into one group
- Allows running commands on all servers

---

### 8. Add Group Variables
```
echo "[servers:vars]" >> inventory.ini
echo "ansible_python_interpreter=/usr/bin/python3" >> inventory.ini
```
- Applies Python interpreter to all servers

---

### 9. Cleanup
```
rm temp.json
```
Deletes temporary file

---

### 10. Confirmation Message
```
echo "Inventory generated successfully!"
```

---

## Final Output Example

```
[ubuntu]
worker-ubuntu ansible_host=... ansible_user=ubuntu

[redhat]
worker-redhat ansible_host=... ansible_user=ec2-user

[amazon]
worker-amazon ansible_host=... ansible_user=ec2-user

[servers]
worker-ubuntu
worker-redhat
worker-amazon

[servers:vars]
ansible_python_interpreter=/usr/bin/python3
```

---

## Key Concepts

| Concept | Meaning |
|--------|--------|
| terraform output -json | Get infra data |
| jq | Process JSON |
| select() | Filter data |
| keys[] | Extract hostnames |
| > | Overwrite file |
| >> | Append file |

---

## Workflow

```
terraform apply
terraform refresh
./generate_inventory.sh
ansible all -m ping
```

---

## Summary

This script acts as a bridge between:
- Terraform (infrastructure)
- Ansible (configuration)

It automates inventory creation and removes manual updates.
