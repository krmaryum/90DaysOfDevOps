# Remove Default Nginx Config on RedHat - Explained

```yaml
- name: Remove default Nginx config on RedHat
  file:
    path: "{{ item }}"
    state: absent
  loop:
    - /etc/nginx/conf.d/default.conf
    - /etc/nginx/conf.d/welcome.conf
  when: ansible_facts['os_family'] == "RedHat"
  notify: Reload Nginx
  tags: nginx
```

---

# Task Name

```yaml
- name: Remove default Nginx config on RedHat
```

This is a readable description of the task.

When Ansible runs, it displays:

```text
TASK [nginx : Remove default Nginx config on RedHat]
```

---

# File Module

```yaml
file:
```

The `file` module manages:
- files
- directories
- symbolic links
- permissions

In this task, it is used to remove files.

---

# Path

```yaml
path: "{{ item }}"
```

The `path` parameter specifies which file should be managed.

---

# What is item?

`item` is a special variable automatically created by `loop`.

Each time the loop runs:
- `item` gets one value from the loop list.

---

# Loop

```yaml
loop:
  - /etc/nginx/conf.d/default.conf
  - /etc/nginx/conf.d/welcome.conf
```

This means:
- run the same task multiple times
- once for each file

---

# First Iteration

During the first loop:

```yaml
item = /etc/nginx/conf.d/default.conf
```

Ansible internally runs:

```yaml
file:
  path: /etc/nginx/conf.d/default.conf
  state: absent
```

---

# Second Iteration

During the second loop:

```yaml
item = /etc/nginx/conf.d/welcome.conf
```

Ansible internally runs:

```yaml
file:
  path: /etc/nginx/conf.d/welcome.conf
  state: absent
```

---

# State

```yaml
state: absent
```

Means:

> Remove the file if it exists.

Equivalent Linux command:

```bash
rm -f filename
```

---

# When Condition

```yaml
when: ansible_facts['os_family'] == "RedHat"
```

This task runs only on:
- RedHat
- Rocky Linux
- AlmaLinux
- CentOS

It skips Debian and Ubuntu systems.

---

# Notify

```yaml
notify: Reload Nginx
```

If this task changes anything:
- Ansible triggers a handler

Example handler:

```yaml
- name: Reload Nginx
  service:
    name: nginx
    state: reloaded
```

Equivalent Linux command:

```bash
sudo systemctl reload nginx
```

---

# Tags

```yaml
tags: nginx
```

Allows running only nginx-related tasks.

Example:

```bash
ansible-playbook site.yml --tags nginx
```

---

# What Happens Internally

Ansible behaves like this:

## First

```yaml
file:
  path: /etc/nginx/conf.d/default.conf
  state: absent
```

## Then

```yaml
file:
  path: /etc/nginx/conf.d/welcome.conf
  state: absent
```

The loop automatically repeats the task for each file.

---

# Why Loop is Better

Instead of writing multiple similar tasks:

```yaml
- name: Remove default.conf
```

and:

```yaml
- name: Remove welcome.conf
```

Using `loop`:
- reduces duplicate code
- keeps playbooks cleaner
- scales easily
- follows production Ansible practices

---

# Summary

This task:
- removes default Nginx configuration files
- uses the `file` module
- loops through multiple files
- runs only on RedHat systems
- reloads Nginx if changes occur
- uses tags for selective execution
