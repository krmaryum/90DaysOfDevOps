# Ansible Common Role Notes

## What is the `common` tag?

In Ansible, `tags` let you run only specific tasks or groups of tasks.

Example:

```yaml
- name: Install common packages
  apt:
    name: "{{ common_packages }}"
    state: present
  tags: common
```

The tag `common` is a custom label used for baseline server setup tasks.

---

## Running Tagged Tasks

Run only tasks tagged with `common`:

```bash
ansible-playbook site.yml --tags common
```

Skip tasks tagged with `common`:

```bash
ansible-playbook site.yml --skip-tags common
```

---

## Industry Practice

Common tags used in DevOps projects:

- common
- setup
- nginx
- docker
- deploy
- database
- security

The `common` role usually includes:

- Base packages
- Hostname setup
- Timezone configuration
- User creation
- SSH configuration
- Monitoring tools

This role is meant to configure every server with standard baseline settings.

---

## UTC and Timezones

Industry practice for production servers:

- Use UTC timezone
- Use 24-hour (military) time format

Example Ansible variable:

```yaml
timezone: UTC
```

Why UTC is preferred:

- Avoids timezone confusion
- Easier log correlation
- Better for distributed systems
- Standard in cloud and Kubernetes environments

---

## Ubuntu Common Role Example

### `roles/common/tasks/main.yml`

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

### `group_vars/all.yml`

```yaml
---
timezone: UTC
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
