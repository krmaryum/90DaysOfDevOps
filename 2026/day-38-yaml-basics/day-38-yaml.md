# Day 38 – YAML Basics

# Table of Contents

| Section | Summary | Link |
|----------|----------|----------|
| Day Overview | Introduction to YAML and its importance in DevOps | [Day Overview](#day-overview) |
| Learning Objectives | Skills and concepts covered in Day 38 | [Learning Objectives](#learning-objectives) |
| YAML Rules to Remember | Basic YAML syntax rules and best practices | [YAML Rules to Remember](#yaml-rules-to-remember) |
| Task 1 – Key-Value Pairs | Create a simple YAML file using key-value pairs | [Task 1](#task-1--key-value-pairs) |
| Task 2 – Lists | Learn block style and inline style YAML lists | [Task 2](#task-2--lists) |
| Task 3 – Nested Objects | Create nested YAML structures using indentation | [Task 3](#task-3--nested-objects) |
| Task 4 – Multi-line Strings | Use Literal (pipe) and Folded (greater-than) styles for multi-line text | [Task 4](#task-4--multi-line-strings) |
| Task 5 – Validate Your YAML | Validate YAML files and fix indentation errors | [Task 5](#task-5--validate-your-yaml) |
| Task 6 – Spot the Difference | Identify and fix YAML indentation problems | [Task 6](#task-6--spot-the-difference) |
| What I Learned | Key concepts learned throughout the day | [What I Learned](#what-i-learned) |

---

## Day Overview
Originally, YAML stood for "Yet Another Markup Language", but later the creators changed it to "YAML Ain't Markup Language" to emphasize that YAML is meant for data representation, not for creating documents like HTML or XML.

YAML is a human-readable data serialization language widely used in DevOps, Cloud Computing, Automation, Infrastructure as Code (IaC), Kubernetes, Docker Compose, Ansible, GitHub Actions, GitLab CI/CD, and many other modern tools.

Before building CI/CD pipelines, it is essential to understand YAML because almost every pipeline configuration file is written using YAML syntax.

This day focuses on learning YAML fundamentals, creating YAML files manually, understanding indentation rules, working with different data types, and validating YAML files.

---

# Learning Objectives

By the end of this day, you will be able to:

* Understand YAML syntax and structure
* Create valid YAML files from scratch
* Work with key-value pairs
* Create YAML lists (arrays)
* Create nested objects
* Use different YAML data types
* Follow YAML indentation rules
* Validate YAML files using online tools
* Avoid common YAML mistakes
* Prepare for future CI/CD pipeline development such as GitHub Actions, GitLab CI/CD, Kubernetes, and Ansible YAML files

---

# Expected Output

The following files should be created:

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

# YAML Rules to Remember

## Rule 1: Use Spaces Only

Correct:

```yaml
name: Khalid
```

Wrong:

```yaml
name: Khalid
	role: DevOps
```

Never use tabs.

---

## Rule 2: Indentation Matters

Standard indentation:

```yaml
employee:
  name: Khalid
  role: DevOps
```

Use 2 spaces.

---

## Rule 3: Strings Usually Don't Need Quotes
In YAML, a string is simply text.

Unlike many programming languages, YAML usually allows you to write strings without quotation marks.


Valid:

```yaml
name: Khalid Khan
```

Quotes only when special characters exist:

```yaml
message: "Hello: YAML"
```

---

## Rule 4: Boolean Values

Boolean:

```yaml
learning: true
active: false
```

String:

```yaml
learning: "true"
```

These are not the same.

---

## Rule 5: YAML is Case Sensitive

```yaml
name: Khalid
```

is different from

```yaml
Name: Khalid
```

---

# Task 1 – Key-Value Pairs

## Objective

Learn the most basic YAML structure:

```yaml
key: value
```

---

## Create person.yaml

```yaml
name: Khalid Khan
role: DevOps Engineer
experience_years: 4
learning: true
```
## Explanation

| Key              | Value Type |
| ---------------- | ---------- |
| name             | String     |
| role             | String     |
| experience_years | Integer    |
| learning         | Boolean    |

## Important

### Correct Boolean:
```yml
learning: true
```
### Wrong (this becomes a string):
```yml
learning: "true"
```

---

## Verify

```bash
cat person.yaml
```

```text
---
name: Khalid Khan
role: DevOps Engineer
experience: 4 years
learning: true
```

---

## What You Learned

* YAML uses key-value pairs
* YAML supports strings
* YAML supports numbers
* YAML supports booleans
* YAML uses spaces instead of tabs

---

## Online Validation

Visit:

https://www.yamllint.com

---
Paste

### person.yaml

```yaml
name: Khalid Khan
role: DevOps Engineer
experience_years: 4
learning: true
```
You should receive:
```text
YAML valid
```

---

## Common YAML Errors

### Using Tabs

Wrong:

```yaml
employee:
	name: Khalid
```

---

### Missing Colon

Wrong:

```yaml
name Khalid
```

Correct:

```yaml
name: Khalid
```

---

### Incorrect Indentation

Wrong:

```yaml
employee:
name: Khalid
```

Correct:

```yaml
employee:
  name: Khalid
```

---

# Task 1 Summary

### You learned:

* YAML uses key: value
* Indentation uses spaces only
* Booleans are true or false
* Numbers don't need quotes
* YAML files should be validated before use

--- 

# Task 2 – Lists
### Objective

> Learn how to store multiple values under a single key using YAML lists.

## Update `person.yml`

Add the following content:
```yml
name: Khalid Khan
role: DevOps Engineer
experience_years: 4
learning: true

tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS

hobbies: [Reading, Learning, Walking]
```

## Explanation
### Block Style List
```yml
tools:
  - Linux
  - Git
  - Docker
  - Kubernetes
  - AWS
```

Each item starts with a dash (`-`).

> This is the most common YAML list format.

### Inline Style List
```yml
hobbies: [Reading, Learning, Walking]
```

> Everything is written on a single line inside square brackets.

---

# Notes for day-38-yaml.md
## What are the two ways to write a list in YAML?
1. Block Style List (Most Common)
```yml
tools:
  - Linux
  - Git
  - Docker
```
Advantages:

* Easy to read
* Easy to edit
* Preferred for long lists

2. Inline Style List
```yml
tools: [Linux, Git, Docker]
```
Advantages:

* Short and compact
* Useful for small lists

---

# Task 2 Summary
What I Learned
1. YAML lists can store multiple values under one key.
2. Lists can be written in Block Style using dashes (`-`).
3. Lists can also be written in Inline Style using square brackets (`[]`).

---

## Real DevOps Example
```yml
servers:
  - web01
  - web02
  - db01
```
or
```yml
servers: [web01, web02, db01]
```
> Both are valid YAML and produce the same result.

---

# Task 3 – Nested Objects
## Objective

Learn how YAML represents hierarchical (parent-child) relationships using indentation.

Nested objects are created by placing child keys under a parent key using spaces.

## Create server.yml
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

database:
  host: db-server-01
  name: devops_db

  credentials:
    user: admin
    password: secret123
```

## Understanding the Structure
### Server Section
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80
```
Hierarchy:
```text
server
├── name
├── ip
└── port
```

### Database Section
```yml
database:
  host: db-server-01
  name: devops_db
```
Hierarchy:
```text
database
├── host
└── name
```

### Nested Credentials
```yml
credentials:
  user: admin
  password: secret123
```
Hierarchy:
```text
database
└── credentials
    ├── user
    └── password
```
> This demonstrates nested objects inside another nested object.

---

## Verify
cat server.yaml
```text
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

database:
  host: db-server-01
  name: devops_db

  credentials:
    user: admin
    password: secret123
```

# Validation Test – Using a TAB

Replace spaces before name with a TAB:

❌ Incorrect (TAB used)

```yml
server:
    name: web-server-01
  ip: 192.168.1.10
```
(The indentation before `name` is a TAB.)

## Validate on Yamllint

Paste the file into:

https://www.yamllint.com

You will get an error similar to:
```text
found character '\t' that cannot start any token
```
or
```text
syntax error: tabs are not allowed
```

# Notes for day-38-yaml.md
## What are Nested Objects?

> Nested objects allow related data to be grouped together under a parent key.

Example:
```yml
database:
  host: db-server-01

  credentials:
    user: admin
    password: secret123
```
Here:

* `database` is the parent object.
* `host` and `credentials` are child objects.
* `user` and `password` are children of `credentials`.

## What Happens if Tabs Are Used?
* YAML validation fails.
* Parsers cannot read the file correctly.
* Error messages indicate that tabs are not allowed.
* Always use spaces (2 spaces is the standard).

## What I Learned
1. YAML uses indentation to create nested objects.
2. Objects can contain other objects.
3. Tabs are invalid in YAML; only spaces should be used.

### Real DevOps Example

Files used by [Ansible](https://docs.ansible.com/), [Docker Compose](https://docs.docker.com/compose/), and [Kubernetes](https://kubernetes.io/docs/home/) often contain deeply nested YAML structures similar to the `database` -> `credentials` -> `user/password` example above.

---

# Task 4 – Multi-line Strings
## Objective

Learn how to store multi-line text in YAML using:

*  `|` (Literal Block Style)
* `>` (Folded Block Style)

These are commonly used in CI/CD pipelines, Kubernetes manifests, Docker Compose files, and shell scripts.

## Update server.yaml
### Using `|` (Literal Block Style)
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

  startup_script: |
    #!/bin/bash
    echo "Starting web server"
    systemctl start nginx
    systemctl status nginx
```

## What Happens?

The line breaks are preserved exactly as written.

Result:
```bash
#!/bin/bash
echo "Starting web server"
systemctl start nginx
systemctl status nginx
```

---

### Using `>` (Folded Block Style)

Add another field:
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

  startup_script: |
    #!/bin/bash
    echo "Starting web server"
    systemctl start nginx
    systemctl status nginx

  description: >
    This server hosts the web application.
    It runs Nginx and serves client requests.
    Monitoring is enabled.
```

## What Happens?

YAML folds the lines into a single line.

Result:
```text
This server hosts the web application. It runs Nginx and serves client requests. Monitoring is enabled.
```

# Complete Example
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80

  startup_script: |
    #!/bin/bash
    echo "Starting web server"
    systemctl start nginx
    systemctl status nginx

  description: >
    This server hosts the web application.
    It runs Nginx and serves client requests.
    Monitoring is enabled.

database:
  host: db-server-01
  name: devops_db

  credentials:
    user: admin
    password: secret123
```

# Notes for day-38-yaml.md
## Multi-line Strings in YAML

YAML provides two ways to write multi-line text:

1. Literal Style (`|`)
```yml
message: |
  Line 1
  Line 2
  Line 3
```
Output:
```text
Line 1
Line 2
Line 3
```
> Newlines are preserved.

2. Folded Style (`>`)
```yml
message: >
  Line 1
  Line 2
  Line 3
```
Output:
```text
Line 1 Line 2 Line 3
```
> Newlines are converted into spaces.

# When Would You Use `|`vs `>` ?

| Symbol | Name | Use Case |
|---------|---------|---------|
| `|` | Literal Block Style | Shell scripts, configuration files, commands, code blocks |
| `>` | Folded Block Style | Long descriptions, notes, comments, documentation text |                                   |

## Real Examples
### Use `|` for Scripts
```yml
startup_script: |
  #!/bin/bash
  systemctl start nginx
  systemctl enable nginx
```
> Reason: Commands must stay on separate lines.

### Use > for Descriptions
```yml
description: >
  This server hosts the company website.
  Monitoring and backups are enabled.
```

> Reason: You want a readable paragraph, not separate lines.

---

# What I Learned
1. `|` preserves line breaks exactly.
2. `>` converts multiple lines into a single paragraph.
3. `|` is commonly used for scripts, while `>` is commonly used for descriptions and documentation.

---

## Quick Memory Tip
`|`  = Keep lines exactly as written
`>`  = Join lines into one paragraph

Think:

`|` → Keep
`>` → Fold (combine lines)

---

# Task 5 – Validate Your YAML
## Objective

Learn how to check YAML syntax, find indentation errors, and fix them.

## Option 1: Use Online Validator

Open:
```text
https://www.yamllint.com
```
Paste your YAML content and validate it.

## Option 2: Install yamllint

### Ubuntu / WSL
```bash
sudo apt update
sudo apt install yamllint -y
```
### RHEL / CentOS / Rocky Linux
```bash
sudo dnf install yamllint -y
```

## Validate Both YAML Files
```bash
yamllint person.yaml
yamllint server.yaml
```

If everything is correct, you may see no major error, or only style warnings.

---

### Intentionally Break Indentation

Example wrong YAML:
```yml
server:
    name: web-server-01
  ip: 192.168.1.10
  port: 80
```
Here, `name` has a tab instead of spaces.

---

## Possible Error

You may get an error like:
```text
syntax error: found character '\t' that cannot start any token
```
or:
```text
wrong indentation: expected 2 but found 1
```

## Fix It

Correct YAML:
```yml
server:
  name: web-server-01
  ip: 192.168.1.10
  port: 80
```
Then validate again:
```bash
yamllint server.yaml
```

## What I Learned
1. YAML does not allow tabs for indentation.
2. YAML indentation must be consistent.
3. Validators help catch syntax mistakes before using YAML in DevOps tools.

---

# Task 6 – Spot the Difference
## Objective

Identify the indentation problem in the second YAML block.

## Block 1 (Correct)
```yml
name: devops

tools:
  - docker
  - kubernetes
```
> Both list items are aligned at the same indentation level.

## Block 2 (Broken)
```yml
name: devops

tools:
- docker
  - kubernetes
```
## What's Wrong?

The list indentation is inconsistent:

* docker starts directly under tools:
* kubernetes has two extra spaces before -

> YAML requires all items in the same list to have the same indentation.

## Correct Version
```yml
name: devops

tools:
  - docker
  - kubernetes
```
or
```yml
name: devops

tools:
- docker
- kubernetes
```
> Both are valid because the list items are aligned consistently.

# What I Learned
1. YAML is indentation-sensitive.
2. All items in a list must have consistent indentation.
3. Incorrect indentation can cause YAML validation errors.


### Key Learning from Task 6

YAML doesn't just care about spaces—it cares about **consistent spaces**. Two list items at different indentation levels are treated as different structures, which can make the file invalid.

---

