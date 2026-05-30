# Visualizing Data Structures: From Simple to Complex

## Introduction

When learning YAML, DevOps, Python, JSON, Kubernetes, Docker Compose, Ansible, or Data Structures, it helps to visualize data from simple structures to more complex structures.

Understanding these relationships makes reading and writing YAML much easier.

---

# Level 1: Single Value

A single value stores one piece of information.

## Visual Representation

```text
name = Khalid
```

## Python

```python
name = "Khalid"
```

## YAML

```yaml
name: Khalid
```

---

# Level 2: List (Array)

A list stores multiple values of the same type.

## Visual Representation

```text
tools
├── Linux
├── Git
├── Docker
├── Kubernetes
└── AWS
```

## Python

```python
tools = [
    "Linux",
    "Git",
    "Docker",
    "Kubernetes",
    "AWS"
]
```

## YAML

```yaml
tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

---

# Level 3: Dictionary (Object)

A dictionary stores data using key-value pairs.

## Visual Representation

```text
person
├── name = Khalid
├── role = DevOps Engineer
└── experience = 4
```

## Python

```python
person = {
    "name": "Khalid",
    "role": "DevOps Engineer",
    "experience": 4
}
```

## YAML

```yaml
person:
  name: Khalid
  role: DevOps Engineer
  experience: 4
```

---

# Level 4: Dictionary Containing a List

A dictionary can contain lists.

## Visual Representation

```text
employee
├── name = Khalid
└── skills
    ├── Linux
    ├── Docker
    └── Kubernetes
```

## Python

```python
employee = {
    "name": "Khalid",
    "skills": [
        "Linux",
        "Docker",
        "Kubernetes"
    ]
}
```

## YAML

```yaml
employee:
  name: Khalid

  skills:
    - Linux
    - Docker
    - Kubernetes
```

---

# Level 5: Nested Dictionary

A dictionary can contain another dictionary.

## Visual Representation

```text
database
├── host = db-server
├── port = 3306
└── credentials
    ├── user = admin
    └── password = secret123
```

## Python

```python
database = {
    "host": "db-server",
    "port": 3306,
    "credentials": {
        "user": "admin",
        "password": "secret123"
    }
}
```

## YAML

```yaml
database:
  host: db-server
  port: 3306

  credentials:
    user: admin
    password: secret123
```

---

# Level 6: List of Dictionaries

One of the most common DevOps structures.

## Visual Representation

```text
servers
├── server1
│   ├── name = web01
│   └── ip = 192.168.1.10
│
└── server2
    ├── name = web02
    └── ip = 192.168.1.11
```

## Python

```python
servers = [
    {
        "name": "web01",
        "ip": "192.168.1.10"
    },
    {
        "name": "web02",
        "ip": "192.168.1.11"
    }
]
```

## YAML

```yaml
servers:
  - name: web01
    ip: 192.168.1.10

  - name: web02
    ip: 192.168.1.11
```

---

# Level 7: Real DevOps Structure

This combines lists and dictionaries together.

## Visual Representation

```text
application
├── name = my-app
├── version = 1.0
├── servers
│   ├── web01
│   └── web02
│
└── database
    ├── host = db-server
    └── port = 3306
```

## YAML

```yaml
application:
  name: my-app
  version: 1.0

  servers:
    - web01
    - web02

  database:
    host: db-server
    port: 3306
```

---

# Data Structure Hierarchy

```text
Value
 └── name: Khalid

List
 └── tools
      ├── Linux
      ├── Git
      └── Docker

Dictionary
 └── person
      ├── name
      ├── role
      └── experience

Nested Dictionary
 └── database
      └── credentials
           ├── user
           └── password

List of Dictionaries
 └── servers
      ├── web01
      │    ├── name
      │    └── ip
      └── web02
           ├── name
           └── ip
```

---

# YAML Mapping Guide

| Structure | YAML Representation |
|------------|----------------------|
| Single Value | `name: Khalid` |
| List | `- Linux` |
| Dictionary | `key: value` |
| Nested Dictionary | Indentation |
| List in Dictionary | Key + List |
| Dictionary in List | `- key: value` |
| List of Dictionaries | Multiple `- key: value` blocks |

---

# Why This Matters in DevOps

These structures are used everywhere:

- GitHub Actions
- GitLab CI/CD
- Kubernetes Manifests
- Docker Compose
- Ansible Playbooks
- Helm Charts
- CloudFormation Templates

---

# Summary

Every YAML file is built using combinations of:

1. Values
2. Lists
3. Dictionaries
4. Nested Dictionaries
5. Lists of Dictionaries

Mastering these structures makes it easier to understand and create real-world DevOps configuration files.

---

# Lists and Dictionaries from Python to YAML

## Introduction

Understanding Python Lists and Dictionaries makes YAML much easier to learn because YAML represents data using similar structures.

---

# 1. Dictionary → YAML

## Python Dictionary

```python
person = {
    "name": "Khalid Khan",
    "role": "DevOps Engineer",
    "experience": 4,
    "learning": True
}
```

## YAML Equivalent

```yaml
person:
  name: Khalid Khan
  role: DevOps Engineer
  experience: 4
  learning: true
```

---

# 2. List → YAML

## Python List

```python
tools = [
    "Linux",
    "Git",
    "Docker",
    "Kubernetes",
    "AWS"
]
```

## YAML Equivalent

```yaml
tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

---

# 3. Dictionary with List

## Python

```python
employee = {
    "name": "Khalid",
    "skills": ["Linux", "Docker", "Kubernetes"]
}
```

## YAML

```yaml
employee:
  name: Khalid
  skills:
    - Linux
    - Docker
    - Kubernetes
```

---

# 4. Nested Dictionary

## Python

```python
database = {
    "host": "db-server",
    "port": 3306,
    "credentials": {
        "user": "admin",
        "password": "secret123"
    }
}
```

## YAML

```yaml
database:
  host: db-server
  port: 3306

  credentials:
    user: admin
    password: secret123
```

---

# 5. List of Dictionaries

## Python

```python
servers = [
    {"name": "web01", "ip": "192.168.1.10"},
    {"name": "web02", "ip": "192.168.1.11"}
]
```

## YAML

```yaml
servers:
  - name: web01
    ip: 192.168.1.10

  - name: web02
    ip: 192.168.1.11
```

---

# Real DevOps Example

```yaml
application:
  name: my-app
  version: 1.0

  servers:
    - web01
    - web02

  database:
    host: db-server
    port: 3306
```

---

# Quick Comparison Table

| Python Structure | YAML Representation |
|------------------|---------------------|
| Dictionary | key: value |
| List | - item |
| Nested Dictionary | Indentation |
| List in Dictionary | Key + list items |
| Dictionary in List | - key: value |

---

# Easy Memory Rule

```text
Dictionary = key: value

List = - item

Indentation = hierarchy
```

---

# Summary

Most YAML files used in DevOps are combinations of:

- Dictionaries (Mappings)
- Lists (Arrays)
- Nested Dictionaries
- Lists of Dictionaries

Once you understand these structures, reading and writing YAML files for Kubernetes, Docker Compose, Ansible, and GitHub Actions becomes much easier.

