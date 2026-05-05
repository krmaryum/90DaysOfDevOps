# Ansible site.yml

## Overview
The `site.yml` file is the main Ansible playbook used to execute roles on target servers. It acts as the entry point for automation and defines which hosts to target and which roles to apply.

---

## Purpose
The purpose of `site.yml` is to:
- Define target hosts
- Apply one or more roles
- Pass variables to roles
- Control execution flow

---

## Example

```yaml
---
- name: Configure web servers
  hosts: ubuntu_web
  become: true

  roles:
    - role: webserver
      vars:
        app_name: terraweek
        http_port: 80
        app_env: development
```

---

## Key Components

### name
Provides a description of the play.
```
- name: Configure web servers
```

---

### hosts
Defines the group of servers from inventory.
```
hosts: ubuntu_web
```

---

### become
Enables privilege escalation (sudo).
```
become: true
```

---

### roles
Specifies which roles to apply.
```
roles:
  - role: webserver
```

---

### vars
Overrides default variables defined in the role.
```
vars:
  app_name: terraweek
```

---

## Execution Flow

1. Run `ansible-playbook site.yml`
2. Ansible connects to target hosts
3. Applies the specified role
4. Executes tasks from the role
5. Deploys templates and configurations
6. Triggers handlers if needed

---

## Relationship with Roles

| Component | Purpose |
|----------|--------|
| site.yml | Entry point |
| roles/   | Reusable automation |
| tasks/   | Execution logic |

---

## Why It Is Important

- Central control of automation
- Connects roles and infrastructure
- Allows variable overrides
- Simplifies execution

---

## Conclusion

The `site.yml` file is the starting point of Ansible automation. It defines which systems to configure and which roles to run, making it essential for managing infrastructure efficiently.
