# Day 69 - Ansible: When to Use Modules vs Shell

## Overview

This guide explains when to use Ansible modules and when to use the shell/command modules. This is an important concept for writing clean, idempotent, and production-ready playbooks.

---

## Core Rule

> Always use Ansible modules first. Use shell/command only when necessary.

---

## ✅ Use Modules (Best Practice)

Modules are:
- Idempotent (safe to run multiple times)
- Structured
- Reliable

### Examples

#### Install package
```yaml
- name: Install nginx
  apt:
    name: nginx
    state: present
```

#### Create directory
```yaml
- name: Create directory
  file:
    path: /opt/myapp
    state: directory
```

#### Manage service
```yaml
- name: Start nginx
  service:
    name: nginx
    state: started
```

---

## ❌ Avoid Shell for These

```yaml
- name: Bad practice
  shell: mkdir /opt/myapp
```

Problems:
- Not idempotent
- Can fail if already exists
- Harder to debug

---

## ✅ Use Shell / Command When Needed

Use shell when:
- You need pipes (`|`)
- You need redirects (`>`)
- You need complex commands

### Example

```yaml
- name: Count processes
  shell: ps aux | wc -l
```

---

## 🔍 command vs shell

| Feature | command | shell |
|--------|--------|------|
| Pipes (`|`) | ❌ | ✅ |
| Redirects (`>`) | ❌ | ✅ |
| Safer | ✅ | ❌ |
| Preferred | ✅ | Only if needed |

---

## 🧠 Examples

### Good (module)
```yaml
file:
  path: /opt/myapp
  state: directory
```

### Bad (shell)
```yaml
shell: mkdir /opt/myapp
```

---

### Good (shell use case)
```yaml
shell: curl -s ifconfig.me
```

---

## 🎯 Decision Guide

| Task | Use |
|-----|-----|
| Install package | apt / yum |
| Manage service | service |
| Create file/dir | file |
| Copy file | copy |
| Simple command | command |
| Complex command | shell |

---

## 🚀 Summary

- Prefer modules for automation
- Use shell only when modules cannot do the job
- Write idempotent playbooks
- Keep automation clean and predictable

---

## 🔥 One-Line Rule

> If a module exists → use it  
> If not → use shell
