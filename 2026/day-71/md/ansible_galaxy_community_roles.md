# Ansible Galaxy - Using Community Roles

## What is Ansible Galaxy?

**Ansible Galaxy** is a platform where you can find, share, and reuse Ansible roles and collections created by the community.

It works like an app store for automation.

---

## What are Community Roles?

A **role** is a structured way to organize Ansible tasks, variables, files, and templates.

Community roles are:
- Pre-built by other users
- Designed for common tasks (e.g., Nginx, MySQL, Docker)
- Shared on Ansible Galaxy

---

## Why Use Ansible Galaxy?

- Saves time by reusing existing work
- Follows best practices
- Large library of roles
- Easy to integrate into projects

---

## Installing a Role

```bash
ansible-galaxy role install geerlingguy.nginx
```

---

## Using a Role in Playbook

```yaml
- hosts: web
  roles:
    - geerlingguy.nginx
```

---

## Using Requirements File

### requirements.yml
```yaml
roles:
  - name: geerlingguy.nginx
  - name: geerlingguy.mysql
```

### Install roles
```bash
ansible-galaxy install -r requirements.yml
```

---

## Role Structure

```
roles/
  nginx/
    tasks/
    handlers/
    templates/
    files/
    vars/
    defaults/
```

---

## Collections (Modern Approach)

Collections bundle roles, modules, and plugins.

### Install collection
```bash
ansible-galaxy collection install community.docker
```

### Use in playbook
```yaml
- hosts: all
  tasks:
    - name: Run container
      community.docker.docker_container:
        name: myapp
```

---

## Best Practices

- Check ratings and documentation
- Pin versions in requirements.yml
- Test before production

---

## Summary

Ansible Galaxy allows you to reuse community-built roles and collections to automate tasks quickly and efficiently.
