# Ansible Jinja2 Templates - Quick Guide

## What is Jinja2 in Ansible?
Jinja2 templates allow you to create dynamic configuration files using variables, loops, and conditions.

Template files usually have the `.j2` extension.

---

## Example Template

```jinja2
server {
    listen {{ http_port }};
    server_name {{ domain_name }};
}
```

## Variables

```yaml
http_port: 80
domain_name: example.com
```

## Rendered Output

```nginx
server {
    listen 80;
    server_name example.com;
}
```

---

## Using the Template Module

```yaml
- name: Deploy nginx config
  ansible.builtin.template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
```

---

## Common Jinja2 Syntax

### Variables
```jinja2
{{ variable_name }}
```

### Conditionals
```jinja2
{% if enable_ssl %}
ssl on;
{% endif %}
```

### Loops
```jinja2
{% for user in users %}
User {{ user }}
{% endfor %}
```

### Filters
```jinja2
{{ app_name | upper }}
{{ port | default(8080) }}
```

---

## Loop Example

### Variables
```yaml
users:
  - alice
  - bob
```

### Template
```jinja2
{% for user in users %}
create user {{ user }}
{% endfor %}
```

### Output
```
create user alice
create user bob
```

---

## Summary
Jinja2 templates help Ansible generate customized configuration files dynamically for different hosts and environments.
