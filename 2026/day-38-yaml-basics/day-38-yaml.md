# Day 38 – YAML Basics

## Additional Topics

| Section | Summary | Link |
|----------|----------|----------|
| YAML Dictionaries | Understanding mappings and objects | [YAML Dictionaries](#yaml-dictionaries-mappings) |
| YAML Data Types | Common YAML data types | [YAML Data Types](#yaml-data-types) |
| Comments in YAML | Using comments in YAML files | [Comments in YAML](#comments-in-yaml) |
| YAML vs JSON | Comparing YAML and JSON | [YAML vs JSON](#yaml-vs-json) |
| Where YAML is Used | Real-world DevOps use cases | [Where YAML is Used](#where-yaml-is-used) |
| Beyond YAML Basics | Advanced YAML concepts | [Beyond YAML Basics](#beyond-yaml-basics-advanced-topics) |

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
name: Khalid Khan
role: DevOps Engineer
experience_years: 4
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

❌ Incorrect

```yaml
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

Files used by [Ansible](https://docs.ansible.com/), [Docker Compose](https://docs.docker.com/compose/), and [Kubernetes](https://kubernetes.io/docs/home/) often contain deeply nested YAML structures similar to the `database` → `credentials` → `user/password` example above.

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
| Pipe (`|`) | Literal Block Style | Shell scripts, configuration files, commands, code blocks |
| Greater Than (`>`) | Folded Block Style | Long descriptions, notes, comments, documentation text |                   |

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

# YAML Dictionaries (Mappings)

A dictionary (also called a mapping or object) stores data as key-value pairs.

```yaml
person:
  name: Khalid
  role: DevOps Engineer
  experience_years: 4
```

## Nested Dictionary Example

```yaml
database:
  host: db-server
  port: 3306

  credentials:
    user: admin
    password: secret123
```

Dictionaries are heavily used in Kubernetes, Docker Compose, Ansible, GitHub Actions, and GitLab CI/CD.

---

# YAML Data Types

| Type | Example |
|--------|---------|
| String | `name: Khalid` |
| Integer | `age: 50` |
| Float | `version: 1.0` |
| Boolean | `active: true` |
| List | `tools: [Git, Docker]` |
| Dictionary | `person: {name: Khalid}` |
| Null | `value: null` |

---

# Comments in YAML

Comments start with `#`.

```yaml
# This is a comment
name: Khalid

# Server port
port: 8080
```

Comments are ignored by YAML parsers.

---

# YAML vs JSON

YAML:

```yaml
name: Khalid
tools:
  - Git
  - Docker
```

JSON:

```json
{
  "name": "Khalid",
  "tools": ["Git", "Docker"]
}
```

YAML is easier for humans to read and write.

---

# Where YAML is Used

- GitHub Actions
- GitLab CI/CD
- Kubernetes
- Docker Compose
- Ansible
- Prometheus
- Helm Charts
- AWS CloudFormation

---

## Best Practices

1. Use spaces only.
2. Keep indentation consistent.
3. Validate YAML files.
4. Use meaningful key names.
5. Use block lists for readability.

---

## Quick Cheat Sheet

| Item | Example |
|------|---------|
| Key-Value | `name: Khalid` |
| List | `- Docker` |
| Boolean | `true` |
| Number | `8080` |
| Nested Object | `database:` |
| Literal Block | `|` |
| Folded Block | `>` |

---

## Summary

YAML is the foundation of modern DevOps configuration files. Understanding syntax, indentation, lists, nested objects, data types, and validation is essential before working with CI/CD pipelines and automation tools.

# Beyond YAML Basics (Advanced Topics)

The following YAML features are commonly used in real-world DevOps projects but are considered advanced topics and are beyond the scope of Day 38.

---

## 1. Anchors (&) and Aliases (*)

Anchors allow you to define a value once and reuse it multiple times.

Example:

```yaml
defaults: &default_settings
  memory: 2GB
  cpu: 2

server1:
  <<: *default_settings

server2:
  <<: *default_settings
```

### Use Cases

- Kubernetes manifests
- Ansible variables
- Large configuration files
- Reducing duplicate code

---

## 2. Advanced YAML Tags

YAML tags explicitly define data types.

Example:

```yaml
port: !!int 8080
active: !!bool true
price: !!float 99.99
```

### Use Cases

- Data serialization
- Complex application configurations
- YAML parsers requiring strict data types

---

## 3. Multi-Document YAML (---)

A single YAML file can contain multiple documents separated by `---`.

Example:

```yaml
---
name: app1
port: 8080

---
name: app2
port: 9090
```

### Use Cases

- Kubernetes resource definitions
- Cloud configuration files
- Infrastructure-as-Code deployments

---

## 4. Helm Templating

Helm is a package manager for Kubernetes that uses YAML templates.

Example:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.service.name }}
```

### Use Cases

- Kubernetes application deployments
- Environment-specific configurations
- Reusable infrastructure templates

---

## Why These Topics Were Not Covered in Day 38

Day 38 focused on learning the YAML fundamentals:

- Key-value pairs
- Lists
- Nested objects
- Dictionaries
- Multi-line strings
- Validation
- Indentation rules

These concepts form the foundation needed before moving on to advanced YAML features used in Kubernetes, Helm, Ansible, and CI/CD pipelines.

---

## Future Learning Path

After mastering YAML basics, the recommended next topics are:

1. GitHub Actions YAML
2. Docker Compose YAML
3. Kubernetes YAML Manifests
4. Ansible Playbooks
5. Helm Charts and Templates
6. Advanced YAML Features (Anchors, Aliases, Tags)
