# Common Role in Ansible

In Ansible, a **common role** is a reusable role that contains tasks and configurations applied to **all servers** in your infrastructure.

Think of it as the **base setup layer** every machine should have before app-specific configuration happens.

## Example Tasks in a Common Role

Typical tasks include:

- Update package cache
- Install standard utilities (`vim`, `git`, `curl`, etc.)
- Set hostname
- Configure timezone
- Create a deploy user

Example:

```yaml
---
- name: Update package cache
  apt:
    update_cache: true
    cache_valid_time: 3600
  tags: common

- name: Install common packages
  apt:
    name: "{{ common_packages }}"
    state: present
  tags: common

- name: Set hostname
  hostname:
    name: "{{ inventory_hostname }}"
  tags: common

- name: Set timezone
  timezone:
    name: "{{ timezone }}"
  tags: common

- name: Create deploy user
  user:
    name: deploy
    groups: sudo
    shell: /bin/bash
    state: present
    append: true
  tags: common
```

## group_vars/all.yml

```yaml
---
timezone: Asia/Kolkata
project_name: devops-app
app_env: development

common_packages:
  - vim
  - curl
  - wget
  - git
  - htop
  - tree
  - jq
  - unzip
```

## Why Use a Common Role?

A common role helps with:

- Consistency across servers
- Reusability
- Easier maintenance
- Cleaner playbooks
- Faster provisioning

## Typical Additions

Teams often include:

- SSH hardening
- Firewall setup
- NTP/time sync
- Monitoring agents
- Log rotation
- Docker installation
- Basic security configurations

## Example Project Structure

```text
roles/
└── common/
    └── tasks/
        └── main.yml
```

## Applying the Role

```yaml
- hosts: all
  become: true

  roles:
    - common
```

The `common` role acts as the **foundation setup** shared across all servers.
