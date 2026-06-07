# Docker Image: Filesystem and Metadata (A to Z Guide)

## Introduction

A Docker Image is a read-only template used to create containers.

A Docker image contains two major components:

1. Filesystem
2. Metadata

```text
Docker Image
│
├── Filesystem
└── Metadata
```

---

## What is a Filesystem?

The filesystem is the collection of files and directories stored inside the image.

Think of it as the image's internal hard drive.

Examples:

```text
/bin
/etc
/usr
/var
/home
/app
```

When a container starts, it uses these files to run the application.

---

## What Does the Filesystem Include?

### Operating System Files

```text
/bin/bash
/etc/passwd
/usr/bin
```

### Application Code

```text
/app/app.py
/app/index.js
```

### Libraries

```text
Python libraries
Java libraries
Node.js modules
```

### Configuration Files

```text
/etc/nginx/nginx.conf
/etc/mysql/my.cnf
```

---

## Filesystem Example

```text
Filesystem
├── /bin/bash
├── /usr/bin/python3
├── /etc/passwd
├── /app/myapp.py
└── /var/log
```

### Simple Definition

The filesystem contains all files and folders packaged inside the Docker image.

---

# What is Metadata?

Metadata is information about the image.

It tells Docker how the image should behave when it runs.

Metadata is not application data or files.

Instead, it contains configuration and instructions.

---

## Common Metadata Examples

### CMD

Defines the default startup command.

```dockerfile
CMD ["python", "app.py"]
```

---

### ENV

Defines environment variables.

```dockerfile
ENV APP_ENV=production
```

---

### EXPOSE

Documents which ports the application uses.

```dockerfile
EXPOSE 80
```

---

### WORKDIR

Sets the default working directory.

```dockerfile
WORKDIR /app
```

---

### LABEL

Stores additional information.

```dockerfile
LABEL author="Khalid Khan"
```

---

## Metadata Example

```text
Metadata
├── CMD
├── ENV
├── EXPOSE
├── WORKDIR
└── LABEL
```

---

## Filesystem vs Metadata

| Component | Meaning |
|-----------|---------|
| Filesystem | Actual files and directories inside the image |
| Metadata | Configuration and instructions about the image |
| CMD | Default startup command |
| ENV | Environment variables |
| EXPOSE | Intended network ports |
| WORKDIR | Default working directory |
| LABEL | Additional information about the image |

---

## Real Dockerfile Example

```dockerfile
FROM python:3.13

WORKDIR /app

COPY . .

ENV APP_ENV=production

EXPOSE 8000

CMD ["python", "app.py"]
```

### Filesystem Portion

```text
/app
app.py
Python runtime
Libraries
Operating system files
```

### Metadata Portion

```text
WORKDIR=/app
APP_ENV=production
EXPOSE=8000
CMD=python app.py
```

---

## Visual Diagram

```text
Docker Image
│
├── Filesystem
│   ├── OS Files
│   ├── Application Code
│   ├── Libraries
│   └── Configuration Files
│
└── Metadata
    ├── CMD
    ├── ENV
    ├── EXPOSE
    ├── WORKDIR
    └── LABEL
```

---

## Why This Matters in DevOps

Understanding filesystem and metadata helps you:

- Build better Docker images
- Troubleshoot containers
- Configure applications correctly
- Optimize deployments
- Understand how images are created and executed

---

## Quick Revision

| Term | Meaning |
|------|---------|
| Filesystem | Files and folders inside the image |
| Metadata | Configuration and runtime instructions |
| CMD | Startup command |
| ENV | Environment variables |
| EXPOSE | Application ports |
| WORKDIR | Default directory |
| LABEL | Additional image information |

---

## One-Line Definition

A Docker image consists of a filesystem (files and directories) and metadata (configuration and instructions that tell Docker how to run the image).
