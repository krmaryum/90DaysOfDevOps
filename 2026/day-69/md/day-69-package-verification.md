# Day 69 - Package Verification from Control Node

## Overview

In this section, I verified that packages were successfully installed on all worker nodes using Ansible commands executed from the control node.

---

## Objective

- Verify installed packages across all servers
- Use Ansible ad-hoc commands for validation
- Confirm automation results after playbook execution

---

## Methods Used

### 1. Check package versions (Recommended)

```bash
ansible all -m command -a "git --version"
ansible all -m command -a "curl --version"
ansible all -m command -a "wget --version"
```

This confirms that the packages are installed and accessible.

---

### 2. Use package_facts module (Advanced)

```bash
ansible all -m package_facts --become
ansible all -m debug -a "var=ansible_facts.packages.git"
```

This retrieves detailed package information from all nodes.

---

### 3. OS-specific verification

#### Ubuntu (Debian)
```bash
ansible ubuntu_web -m command -a "dpkg -l | grep git"
```

#### RedHat / Amazon Linux
```bash
ansible redhat_app -m command -a "rpm -qa | grep git"
ansible amz_db -m command -a "rpm -qa | grep git"
```

---

### 4. Quick binary check

```bash
ansible all -m command -a "which git"
```

Returns the binary path if installed.

---

## Summary

- Multiple methods were used to verify installed packages
- The most reliable method is checking package versions
- Ansible ad-hoc commands provide a quick and effective way to validate system state

---

## Conclusion

This step ensures that the automation performed by Ansible playbooks is successfully applied across all managed nodes, confirming consistency and correctness.
