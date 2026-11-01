# WSL (Windows Subsystem for Linux) Commands Guide

# What is WSL?

WSL (Windows Subsystem for Linux) allows you to run Linux directly on Windows without using a virtual machine.

---

# Check WSL Status

```powershell
wsl --status
```

---

# Check WSL Version

```powershell
wsl --version
```

---

# Install WSL

```powershell
wsl --install
```

---

# Install Ubuntu

```powershell
wsl --install -d Ubuntu
```

---

# List Installed Distributions

```powershell
wsl -l -v
```

---

# Start WSL

```powershell
wsl
```

---

# Start Specific Distribution

```powershell
wsl -d Ubuntu
```

---

# Shutdown WSL

```powershell
wsl --shutdown
```

---

# Update WSL

```powershell
wsl --update
```

---

# Set Default WSL Version

```powershell
wsl --set-default-version 2
```

---

# Convert Distribution to WSL2

```powershell
wsl --set-version Ubuntu 2
```

---

# Set Default Distribution

```powershell
wsl --set-default Ubuntu
```

---

# Export Distribution

```powershell
wsl --export Ubuntu ubuntu-backup.tar
```

---

# Import Distribution

```powershell
wsl --import Ubuntu D:\WSL\Ubuntu ubuntu-backup.tar
```

---

# Delete Distribution

```powershell
wsl --unregister Ubuntu
```

---

# Linux Commands Inside WSL

## Check Username

```bash
whoami
```

## Check Hostname

```bash
hostname
```

## Check Current Directory

```bash
pwd
```

## Update Packages

```bash
sudo apt update && sudo apt upgrade -y
```

## Install Git

```bash
sudo apt install git -y
```

## Check Git Version

```bash
git --version
```

---

# Windows Drives Inside WSL

| Windows Drive | WSL Path |
|---|---|
| C: | /mnt/c |
| D: | /mnt/d |

Example:

```bash
cd /mnt/c/Users
```

---

# Open VS Code From WSL

```bash
code .
```

---

# Exit WSL

```bash
exit
```

---

# Common Mistake

Wrong:

```powershell
ws1 --version
```

Correct:

```powershell
wsl --version
```

Use lowercase L, not number 1.

---

# Recommended Workflow

## Start Ubuntu

```powershell
wsl
```

## Update Packages

```bash
sudo apt update && sudo apt upgrade -y
```

## Install Git

```bash
sudo apt install git -y
```

## Verify Git

```bash
git --version
```

---

# Example Modern Setup

```text
WSL version: 2.7.3.0
Ubuntu-24.04
Kernel version: 6.6.114.1-1
```

Perfect for:

- Docker
- Kubernetes
- Terraform
- Ansible
- Linux Labs
- DevOps Projects
