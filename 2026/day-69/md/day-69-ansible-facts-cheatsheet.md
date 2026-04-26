# Day 69 - Ansible Facts Cheat Sheet

## Overview

Ansible facts are system variables automatically gathered from managed nodes. These facts provide important information about the system such as OS type, IP address, hostname, memory, and more.

---

## How to Get Ansible Facts

### Get all facts
```bash
ansible all -m setup
```

---

### Get facts for a specific host
```bash
ansible worker-ubuntu -m setup
```

---

### Filter specific facts
```bash
ansible all -m setup -a "filter=ansible_os_family"
ansible all -m setup -a "filter=ansible_hostname"
ansible all -m setup -a "filter=ansible_default_ipv4"
```

---

## Using Facts in Playbooks

Facts are gathered automatically at the start of a play:

```yaml
TASK [Gathering Facts]
```

You can use them like:

```yaml
when: ansible_facts['os_family'] == "Debian"
```

or shorter:

```yaml
when: ansible_os_family == "Debian"
```

---

## Display Facts in Playbook

```yaml
- name: Show OS family
  debug:
    var: ansible_os_family
```

---

## Commonly Used Ansible Facts

| Fact | Description |
|------|------------|
| ansible_os_family | OS family (Debian, RedHat) |
| ansible_distribution | OS name (Ubuntu, Amazon, CentOS) |
| ansible_hostname | Hostname of the system |
| ansible_default_ipv4.address | Private IP address |
| ansible_memtotal_mb | Total memory in MB |
| ansible_processor | CPU details |
| ansible_architecture | System architecture |
| ansible_kernel | Kernel version |
| ansible_uptime_seconds | System uptime |

---

## Example Output

```bash
ansible all -m setup -a "filter=ansible_os_family"
```

Output:
```
worker-ubuntu:
  ansible_os_family: Debian

worker-redhat:
  ansible_os_family: RedHat

worker-amazon:
  ansible_os_family: RedHat
```

---

## Key Notes

- Facts are gathered automatically unless disabled
- Use filters to reduce output size
- Prefer short form like `ansible_os_family` for readability
- Useful for conditional execution (`when`)

---

## Summary

Ansible facts are essential for writing dynamic and OS-aware playbooks. They allow you to create flexible automation that adapts to different environments.
