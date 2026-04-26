# Day 69 - Public IP Verification Using Ansible

## Overview

In this section, I verified the public IP addresses of all managed servers using Ansible ad-hoc commands from the control node.

---

## Objective

- Retrieve public IP addresses of all servers
- Understand difference between private and public IP
- Use Ansible commands to fetch external network information

---

## Methods Used

### 1. Get Public IP using external service (Recommended)

```bash
ansible all -m shell -a "curl -s ifconfig.me"
```

### Output Example

```
worker-ubuntu | SUCCESS => 52.xx.xx.xx
worker-redhat | SUCCESS => 3.xx.xx.xx
worker-amazon | SUCCESS => 18.xx.xx.xx
```
Shows host → IP mapping nicely

---

### 2. Alternative method using ipify

```bash
ansible all -m shell -a "curl -s https://api.ipify.org"
```

---

### 3. AWS Metadata method (only for EC2)

```bash
ansible all -m shell -a "curl -s http://169.254.169.254/latest/meta-data/public-ipv4"
```

---

## Private vs Public IP

| Type | Description |
|------|------------|
| Private IP | Internal IP within VPC (ansible_default_ipv4) |
| Public IP | External IP accessible from internet |

---

## Notes

- `ansible_default_ipv4` shows private IP only
- Use `curl` commands to get public IP
- Public IP may change if instance is restarted (unless Elastic IP is used)

---

## Summary

This step ensures that I can verify external connectivity and identify public endpoints of all servers using Ansible automation.
