# Ansible Galaxy Search Command

## Command
```
ansible-galaxy search nginx --platforms EL
```

---

## Overview
This command is used to search for Ansible roles related to **nginx** on Ansible Galaxy that are compatible with **Enterprise Linux (EL)** systems.

---

## Purpose
- Find reusable nginx roles
- Filter roles based on OS compatibility
- Ensure selected roles work on target systems (RHEL, CentOS, Amazon Linux)

---

## Command Breakdown

### ansible-galaxy
Tool used to interact with the Ansible Galaxy marketplace.

---

### search
Searches for available roles in Ansible Galaxy.

---

### nginx
Keyword used to find roles related to nginx.

---

### --platforms EL
Filters results to only show roles that support Enterprise Linux systems.

---

## What is EL?

EL (Enterprise Linux) includes:

- Red Hat Enterprise Linux (RHEL)
- CentOS
- Rocky Linux
- Amazon Linux (mostly compatible)

---

## How It Works

1. Ansible connects to Ansible Galaxy
2. Searches for roles matching the keyword "nginx"
3. Filters roles that support EL platforms
4. Displays matching roles

---

## Example Output (Simplified)

```
geerlingguy.nginx     Install Nginx on EL systems
jdauphant.nginx       Nginx role
```

---

## Why Use --platforms EL?

Without filter:
```
ansible-galaxy search nginx
```

- May return roles for Ubuntu, Debian, etc.

With filter:
```
ansible-galaxy search nginx --platforms EL
```

- Shows only EL-compatible roles
- Reduces compatibility issues

---

## Real Use Case

For systems like:

```
[redhat_app]
worker-redhat
```

Using `--platforms EL` ensures the selected role works correctly.

---

## Analogy

Searching for "nginx roles" is like searching for "cars".

Using `--platforms EL` is like filtering by "SUV only".

---

## Conclusion

The command helps find nginx roles that are specifically compatible with Enterprise Linux systems, ensuring reliable and compatible automation.
