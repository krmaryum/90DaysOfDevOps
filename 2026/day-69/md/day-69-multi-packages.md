# Day 69 - Extra Task: Multi Package Installation

## Task Overview

In this task, I created a simple Ansible playbook to install multiple packages on Ubuntu-based systems. The playbook demonstrates how to use the `apt` module with a list of packages and apply conditional logic based on the operating system.

---

## Task Objective

- Learn how to install multiple packages using Ansible
- Understand the correct syntax for module parameters
- Use conditional statements to target specific operating systems
- Practice writing clean and structured playbooks

---

## Playbook: multi-pkgs-install.yml

```yaml
---
- name: Multi pkgs install
  hosts: all_servers
  become: true

  tasks:
    - name: Install Multi packages
      apt:
        name:
          - git
          - curl
          - wget
        state: present
        update_cache: true
      when: ansible_facts['os_family'] == "Debian"
```

---

## Key Points

- `apt` module is used for Ubuntu/Debian systems
- `name` accepts a list of packages
- `state: present` ensures packages are installed
- `update_cache: true` updates package index before installation
- `when` condition ensures this runs only on Debian-based systems

---

## Summary

This task helped reinforce the correct structure of Ansible modules and the importance of passing arguments properly using key-value pairs. It also demonstrated how to safely target specific operating systems using conditions.
