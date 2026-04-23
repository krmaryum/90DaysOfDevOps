# Ansible Inventory Explained

## Overview
This document explains the structure and purpose of an Ansible inventory file used to manage multiple EC2 instances.

---

## Inventory Structure

```
[ubuntu]
worker-ubuntu ansible_host=3.19.213.39 ansible_user=ubuntu

[redhat]
worker-redhat ansible_host=18.223.151.60 ansible_user=ec2-user

[amazon]
worker-amazon ansible_host=18.223.114.45 ansible_user=ec2-user

[servers]
worker-ubuntu
worker-redhat
worker-amazon

[servers:vars]
ansible_python_interpreter=/usr/bin/python3
```

---

## 1. Groups

### [ubuntu], [redhat], [amazon]

- These are group names.
- Used to categorize servers based on OS.
- Helps in targeting specific servers.

Example:
```
ansible ubuntu -m ping
```

---

## 2. Host Definition

Example:
```
worker-ubuntu ansible_host=3.19.213.39 ansible_user=ubuntu
```

### Explanation:

| Part | Meaning |
|------|--------|
| worker-ubuntu | Alias (name of server in Ansible) |
| ansible_host | Actual IP address |
| ansible_user | SSH login user |

---

## 3. Combined Group

```
[servers]
worker-ubuntu
worker-redhat
worker-amazon
```

### Purpose:
- Combines all servers into one group.
- Allows running commands on all nodes together.

Example:
```
ansible servers -m ping
```

---

## 4. Group Variables

```
[servers:vars]
ansible_python_interpreter=/usr/bin/python3
```

### Purpose:
- Applies variables to all servers in the group.
- Ensures correct Python interpreter is used.

### Why needed:
Ansible runs Python on remote machines. This ensures compatibility across different OS types.

---

## 5. Execution Flow

When running:
```
ansible servers -m ping
```

Ansible will:
1. Read group [servers]
2. Expand to all hosts
3. Use:
   - IP from ansible_host
   - User from ansible_user
   - Python from ansible_python_interpreter
4. Connect using SSH key (defined in ansible.cfg)

---

## Summary

| Component | Purpose |
|----------|--------|
| Groups | Organize servers |
| Host entries | Define connection details |
| Combined group | Manage all servers together |
| Group vars | Apply shared settings |

---

## Key Takeaway

This structure enables:
- Clean organization
- Easy scaling
- Flexible automation

It is a standard approach used in real-world DevOps projects.
