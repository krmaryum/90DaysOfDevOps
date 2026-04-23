# Ansible Debugging Guide

## Overview

This guide explains how to troubleshoot common Ansible issues based on output colors and errors. It helps identify whether the problem is related to connectivity, permissions, or command execution.

---

## Ansible Output Colors

### Green (SUCCESS / OK / CHANGED)
- Task executed successfully
- OK → No changes were made
- CHANGED → System state was modified

---

### Yellow (UNREACHABLE)
- Ansible cannot connect to the host
- Usually a network or SSH issue

---

### Red (FAILED)
- Task failed during execution
- Usually due to permission or command issues

---

## Debugging Steps

### 1. UNREACHABLE (Connection Issues)

#### Check SSH manually
```bash
ssh -i ./terra-automate-key ubuntu@<ip>
```

#### Check Security Group
- Ensure port 22 is open
- Allow your IP

#### Check Username
- Ubuntu → ubuntu
- Amazon Linux → ec2-user
- RedHat → ec2-user

#### Check Key Permissions
```bash
chmod 400 terra-automate-key
```

---

### 2. FAILED (Execution Issues)

#### Read error message carefully

#### Test command manually
```bash
ssh -i ./terra-automate-key ubuntu@<ip>
sudo apt install git
```

#### Use --become if needed
```bash
ansible all -m apt -a "name=git state=present" --become
```

#### Use correct module
- Ubuntu → apt
- RedHat/Amazon → yum or dnf

---

### 3. SUCCESS but no change

- Task executed but nothing changed
- Likely the desired state is already met

Check manually:
```bash
ansible all -m command -a "git --version"
```

---

## Advanced Debugging

### Use verbose mode
```bash
ansible all -m ping -vvv
```

This shows:
- SSH connection details
- Commands being executed
- Detailed error logs

---

## Debugging Checklist

1. Test SSH manually
2. Verify inventory (IP and user)
3. Check SSH key permissions
4. Use --become for admin tasks
5. Use correct module
6. Run with -vvv for details

---

## Summary

- Green → Success
- Yellow → Connection problem
- Red → Execution problem

Understanding these helps quickly identify and fix issues when working with Ansible.
