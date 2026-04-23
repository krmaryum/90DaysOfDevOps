# Ansible Installation Guide

## System Information

- OS: Ubuntu 24.04.4 LTS (WSL2)
- Architecture: ARM64
- Python: 3.12.3
- Ansible: core 2.20.4 (already installed)

---

[Ansible Docs Link](https://docs.ansible.com/projects/ansible/latest/installation_guide/intro_installation.html#control-node-requirements)

# 1. Ubuntu / WSL Installation

## Install Ansible (APT)

```bash
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
```

## Verify Installation

```bash
ansible --version
```
```text
ansible [core 2.20.4]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/khalid/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/khalid/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.12.3 (main, Mar  3 2026, 12:15:18) [GCC 13.3.0] (/usr/bin/python3)
  jinja version = 3.1.2
  pyyaml version = 6.0.1 (with libyaml v0.2.5)
```

## Install Latest Version Using pipx (Recommended)

```bash
sudo apt install pipx -y
pipx ensurepath
pipx install ansible
```

---

# 2. CentOS / Red Hat / Rocky / AlmaLinux Installation

## Method 1: Install Using DNF

### Install Ansible Core

```bash
sudo dnf install ansible-core -y
```

### Install Full Ansible Package

```bash
sudo dnf install ansible -y
```

---

## Method 2: Enable EPEL Repository (if required)

```bash
sudo dnf install epel-release -y
sudo dnf install ansible -y
```

---

## Method 3: Install Using pip

### Install pip

```bash
sudo dnf install python3-pip -y
```

### Install Ansible

```bash
python3 -m pip install --user ansible
```

| Part    | Meaning                       |
| ------- | ----------------------------- |
| python3 | Use Python 3                  |
| -m pip  | Run pip via Python            |
| install | Install a package             |
| ansible | The package name              |
| --user  | Install only for current user (no `sudo`needed). |


---

## Method 4: Install Using pipx (Recommended)

```bash
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install ansible
```

---

# 3. Verify Installation (All Systems)

```bash
ansible --version
```

---

# Notes

- Ubuntu uses APT package manager.
- CentOS, Red Hat, Rocky, and AlmaLinux use DNF or YUM.
- The command `apt-add-repository` is only for Ubuntu-based systems.
- pipx is recommended for isolated and up-to-date installations.

---

# Recommendation Summary

| System        | Recommended Method |
|--------------|-------------------|
| Ubuntu (WSL) | pipx              |
| RHEL/CentOS  | dnf or pipx       |

---

# File Name

ansible_installation_guide.md

---

# Usage

This guide can be used to install Ansible on:
- Ubuntu systems
- WSL environments
- CentOS / Red Hat based servers
- Rocky Linux and AlmaLinux systems

---

## Workflow Overview

Terraform → Provision EC2 instances  
↓  
Generate inventory (dynamic or script)  
↓  
Update inventory.ini  
↓  
Ansible → SSH → Execute tasks  

## Control Node Setup

Ansible was installed on my local laptop running Ubuntu 24.04 inside WSL (Windows Subsystem for Linux).

This machine acts as the **control node**, where all Ansible commands are executed.

---

## Why Ansible is Installed Only on the Control Node

Ansible is an **agentless configuration management tool**, which means it does not require any software to be installed on the managed nodes.

Instead, Ansible uses SSH to connect to remote servers and execute tasks.

Because of this:

- Ansible only needs to be installed on the control node
- Managed nodes only need:
  - SSH access
  - Python installed (usually pre-installed)

This makes Ansible lightweight and easy to set up compared to tools like Puppet or Chef, which require agents on each server.

---

