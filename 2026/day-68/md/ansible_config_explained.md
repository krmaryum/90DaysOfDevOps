# Ansible Configuration Explained

## Overview
This document explains the purpose of the following Ansible configuration:
```bash
[defaults]
inventory = inventory.ini
private_key_file = terra-automate-key
host_key_checking = False
timeout = 30
forks = 10
```


---

## 1. [defaults]

- Section header in ansible.cfg
- Defines global/default settings for Ansible
- Ansible config file is divided into sections
- `[defaults]` = global settings for all commands

Think of it like:

“These are the default rules for my project”
---

## 2. inventory = inventory.ini

Specifies the inventory file containing servers.

Without:
```bash
ansible all -i inventory.ini -m ping
```

With:
```bash
ansible all -m ping
```

---

## 3. private_key_file = terra-automate-key

Defines SSH key for connecting to servers.

Tells Ansible:

“Use this SSH key to connect to all servers”

Without:
```bash
ansible all -m ping --private-key terra-automate-key
```

With:
```bash
ansible all -m ping
```

---

## 4. host_key_checking = False

Disables SSH host key verification prompt.

Default:
Prompts for confirmation

With False:
- Auto-accepts host keys
- Ansible skips that prompt
- Automatically accepts host keys

Needed for automation ✔️

Note: Good for labs, not production.

### Normally (default = True)

When connecting first time:

Are you sure you want to continue connecting (yes/no)?

This stops automation ❌

### Security note
- Good for labs / automation
- Not ideal for production (less secure)

### timeout = 30
What it means

This is the SSH connection timeout (in seconds)

timeout = 30

Ansible will wait 30 seconds to connect to a server before failing.

### Example

If a server is:

- slow
- not reachable
- booting

Ansible will try for 30 seconds, then give error.

### When to change it

| Situation    | Value       |
| ------------ | ----------- |
| Normal       | `30` (good) |
| Slow network | `60`        |
| Fast/local   | `10–20`     |


### forks = 10

What it means

Number of parallel connections

forks = 10

Ansible will run tasks on 10 servers at the same time

### Example

If you have:

- 3 servers → all run at once ✔️
- 50 servers → runs 10 at a time

### When to change it

| Servers | Suggested forks |
| ------- | --------------- |
| 1–5     | 5               |
| 10–20   | 10–20           |
| 50+     | 20–50           |

### Simple analogy

| Setting | Meaning             |
| ------- | ------------------- |
| timeout | “How long to wait?” |
| forks   | “How many at once?” |


---

## Summary

inventory → server list  
private_key_file → SSH key  
host_key_checking → skip confirmation  

---

## Final Command

ansible all -m ping
