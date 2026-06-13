# Array vs Object (Dictionary)

## Introduction

Arrays (Lists) and Objects (Dictionaries) are the two most important data structures used in:

- YAML
- JSON
- Python
- Kubernetes
- Docker Compose
- Ansible
- GitHub Actions

Understanding the difference between them is essential for working with DevOps configuration files.

---

# What is an Array?

An Array (called a List in Python and YAML) stores multiple values.

## Visual Representation

```text
tools
├── Linux
├── Git
├── Docker
├── Kubernetes
└── AWS
```

## Python Example

```python
tools = [
    "Linux",
    "Git",
    "Docker",
    "Kubernetes",
    "AWS"
]
```

## YAML Example

```yaml
tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

## Characteristics

- Stores multiple values
- Accessed by position (index)
- Values are ordered
- Duplicate values are allowed

---

# What is an Object (Dictionary)?

An Object stores data as key-value pairs.

## Visual Representation

```text
person
├── name = Khalid
├── role = DevOps Engineer
└── experience = 4
```

## Python Example

```python
person = {
    "name": "Khalid",
    "role": "DevOps Engineer",
    "experience": 4
}
```

## YAML Example

```yaml
person:
  name: Khalid
  role: DevOps Engineer
  experience: 4
```

## Characteristics

- Stores key-value pairs
- Accessed by key
- Keys should be unique
- Easy to organize related data

---

# Array vs Object Comparison

| Feature | Array (List) | Object (Dictionary) |
|----------|----------|----------|
| Stores | Multiple values | Key-value pairs |
| Access | By index | By key |
| Ordered | Yes | Key-based |
| Duplicate Values | Allowed | Keys should be unique |
| YAML Syntax | `- item` | `key: value` |
| Python Type | List | Dictionary |

---

# Array of Objects

Very common in Kubernetes and Ansible.

## YAML

```yaml
servers:
  - name: web01
    ip: 192.168.1.10

  - name: web02
    ip: 192.168.1.11
```

## Visualization

```text
servers
├── Object 1
│   ├── name = web01
│   └── ip = 192.168.1.10
│
└── Object 2
    ├── name = web02
    └── ip = 192.168.1.11
```

---

# Object Containing an Array

Also very common.

## YAML

```yaml
employee:
  name: Khalid

  skills:
    - Linux
    - Docker
    - Kubernetes
```

## Visualization

```text
employee
├── name = Khalid
└── skills
    ├── Linux
    ├── Docker
    └── Kubernetes
```

---

# Nested Objects

Objects can contain other objects.

## YAML

```yaml
database:
  host: db-server
  port: 3306

  credentials:
    user: admin
    password: secret123
```

## Visualization

```text
database
├── host = db-server
├── port = 3306
└── credentials
    ├── user = admin
    └── password = secret123
```

---

# Real Kubernetes Example

```yaml
spec:
  containers:
    - name: nginx
      image: nginx

    - name: redis
      image: redis
```

## Structure

```text
spec = Object

containers = Array

containers
├── Object 1
│   ├── name = nginx
│   └── image = nginx
│
└── Object 2
    ├── name = redis
    └── image = redis
```

---

# Real DevOps Example

```yaml
application:
  name: my-app

  servers:
    - web01
    - web02

  database:
    host: db-server
    port: 3306
```

## Visualization

```text
application
├── name = my-app
├── servers
│   ├── web01
│   └── web02
│
└── database
    ├── host
    └── port
```

---

# Easy Memory Rules

```text
Array/List
  = Multiple items
  = Uses -

Object/Dictionary
  = Key-value pairs
  = Uses key: value
```

---

# Quick Cheat Sheet

| Structure | YAML Example |
|------------|--------------|
| Array | `- Linux` |
| Object | `name: Khalid` |
| Array of Objects | `- name: web01` |
| Object with Array | `skills:` |
| Nested Object | `credentials:` |

---

# Summary

Every YAML file is built using combinations of Arrays and Objects.

Examples:

- Kubernetes manifests
- Docker Compose files
- Ansible Playbooks
- GitHub Actions workflows

Once you understand Arrays and Objects, you can read and write most DevOps YAML files with confidence.
