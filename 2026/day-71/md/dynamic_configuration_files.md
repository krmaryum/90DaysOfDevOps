# Dynamic Configuration Files - Explanation

## What is a Dynamic Configuration File?

A **dynamic configuration file** is a file whose content is generated automatically using variables, logic, or environment-specific data instead of being fixed.

---

## Static vs Dynamic

### Static Configuration (Fixed)
```nginx
server {
    listen 80;
    server_name example.com;
}
```

This file does not change unless manually edited.

---

### Dynamic Configuration (Template)
```jinja2
server {
    listen {{ http_port }};
    server_name {{ domain_name }};
}
```

Values are replaced dynamically when the file is generated.

---

## Key Features of Dynamic Configs

### 1. Variables
```jinja2
{{ variable_name }}
```
Used to insert values dynamically.

---

### 2. Conditions
```jinja2
{% if enable_ssl %}
ssl on;
{% endif %}
```
Include or exclude parts of configuration.

---

### 3. Loops
```jinja2
{% for user in users %}
create user {{ user }}
{% endfor %}
```
Repeat blocks automatically.

---

## Real Example (Ansible + Jinja2)

### Variables
```yaml
http_port: 80
domain_name: example.com
```

### Template
```jinja2
server {
    listen {{ http_port }};
    server_name {{ domain_name }};
}
```

### Output
```nginx
server {
    listen 80;
    server_name example.com;
}
```

---

## Why Use Dynamic Configuration?

- Reduces duplication
- Works across multiple environments (dev, staging, prod)
- Easier to maintain
- Scales well in automation

---

## Simple Analogy

A **static file** is like a printed form.  
A **dynamic file** is like a smart form that fills itself based on inputs.

---

## Summary

Dynamic configuration files allow automation tools like Ansible to generate customized configs efficiently using templates and variables.
