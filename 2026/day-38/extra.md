
# Task 2 – YAML Lists (Arrays)

## Objective

Learn how to store multiple values under a single key.

---

## Create skills.yaml

```yaml
skills:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

---

## Verify

```bash
cat skills.yaml
```

Expected output:

```yaml
skills:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

---

## Alternative List Syntax

```yaml
skills: [Linux, Git, Docker, Kubernetes, AWS]
```

---

## What You Learned

* Lists use dashes (-)
* Each list item starts on a new line
* Lists can contain strings, numbers, or objects

---

# Task 3 – Nested Objects

## Objective

Understand YAML indentation and nested structures.

---

## Create company.yaml

```yaml
employee:
  name: Khalid Khan
  role: DevOps Engineer
  department: Operations
```

---

## Verify

```bash
cat company.yaml
```

---

## Structure Explanation

```yaml
employee:
  name: Khalid Khan
```

means:

```text
employee
└── name
```

---

## What You Learned

* Indentation creates hierarchy
* Child keys are indented under parent keys
* Proper spacing is critical

---

# Task 4 – Mixed Data Types

## Objective

Combine strings, numbers, booleans, lists, and nested objects.

---

## Create project.yaml

```yaml
project:
  name: DevOps Learning
  version: 1.0
  active: true

  team:
    - Khalid
    - Ali
    - Ahmed

  environment:
    os: Linux
    cloud: AWS
```

---

## Verify

```bash
cat project.yaml
```

---

## Data Types Used

| Field       | Type    |
| ----------- | ------- |
| name        | String  |
| version     | Number  |
| active      | Boolean |
| team        | List    |
| environment | Object  |

---

## What You Learned

* YAML supports multiple data types
* Lists and objects can be combined
* YAML can represent complex configurations

---

# Task 5 – YAML Validation

## Objective

Ensure your YAML files are syntactically correct.

### skills.yaml

```yaml
skills:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

---

### company.yaml

```yaml
employee:
  name: Khalid Khan
  role: DevOps Engineer
  department: Operations
```

---

### project.yaml

```yaml
project:
  name: DevOps Learning
  version: 1.0
  active: true

  team:
    - Khalid
    - Ali
    - Ahmed

  environment:
    os: Linux
    cloud: AWS
```

---

# Task 6 – Documentation

## Create day-38-yaml.md

Include:

### YAML Files Created

* person.yaml
* skills.yaml
* company.yaml
* project.yaml

---


## Three Key Things I Learned

### 1. Indentation is Everything

YAML uses spaces to define structure and hierarchy.

### 2. Tabs Are Not Allowed

Only spaces should be used.

### 3. YAML Supports Multiple Data Types

Strings, numbers, booleans, lists, and objects can all be represented easily.

---

# Quick YAML Cheat Sheet

## String

```yaml
name: Khalid
```

---

## Number

```yaml
experience: 6
```

---

## Boolean

```yaml
learning: true
```

---

## List

```yaml
skills:
  - Linux
  - Git
```

---

## Nested Object

```yaml
employee:
  name: Khalid
  role: DevOps
```

---

## Object with List

```yaml
team:
  - Khalid
  - Ali
  - Ahmed
```

---

# Folder Structure

```text
2026/
└── day-38/
    ├── person.yaml
    ├── skills.yaml
    ├── company.yaml
    ├── project.yaml
    └── day-38-yaml.md
```

---

# Git Commands

```bash
mkdir -p 2026/day-38

cd 2026/day-38

nano person.yaml
nano skills.yaml
nano company.yaml
nano project.yaml
nano day-38-yaml.md

cat person.yaml
cat skills.yaml
cat company.yaml
cat project.yaml

git add .

git commit -m "Day 38: YAML Basics"

git push
```

---

# Day 38 Completion Summary

Successfully completed:

* Task 1: Key-Value Pairs
* Task 2: YAML Lists
* Task 3: Nested Objects
* Task 4: Mixed Data Types
* Task 5: YAML Validation
* Task 6: Documentation

You are now ready to start working with YAML files used in:

* GitHub Actions
* GitLab CI/CD
* Kubernetes
* Docker Compose
* Ansible
* Jenkins Pipelines
