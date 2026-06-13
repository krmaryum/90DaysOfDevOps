# Understanding Pipelines

## What is a Pipeline?

### Simple Definition

A pipeline is a series of automated steps that take code from development to production.

Think of it like an assembly line in a factory.

Instead of building a product manually, each stage performs a specific task automatically.

---

## Real-Life Example

Imagine washing clothes:

```text
Dirty Clothes
      ↓
Washing
      ↓
Drying
      ↓
Ironing
      ↓
Ready to Wear
```

Each step must happen in order.

This sequence of steps is a pipeline.

---

## Pipeline in Software Development

When a developer writes code:

```text
Write Code
     ↓
Build
     ↓
Test
     ↓
Package
     ↓
Deploy
     ↓
Production
```

This sequence is called a CI/CD Pipeline.

---

## Why Do We Need a Pipeline?

### Without a Pipeline

```text
Developer
    ↓
Build Manually
    ↓
Test Manually
    ↓
Deploy Manually
```

Problems:

- Slow
- Error-prone
- Difficult to repeat

### With a Pipeline

```text
Git Push
    ↓
Pipeline Starts
    ↓
Build
    ↓
Test
    ↓
Deploy
```

Benefits:

- Faster
- Consistent
- Reliable

---

# Pipeline Anatomy

A typical pipeline contains several stages.

## Stage 1 – Source

Developer pushes code.

Example:

```bash
git push origin main
```

---

## Stage 2 – Build

The application is compiled or packaged.

Examples:

```text
Java → JAR
NodeJS → Package
Docker → Image
```

---

## Stage 3 – Test

Automated tests run.

Examples:

- Unit Tests
- Integration Tests
- Security Tests

Purpose:

```text
Verify code works correctly
```

---

## Stage 4 – Package

Application artifacts are prepared.

Examples:

```text
Docker Image
ZIP File
Binary
```

---

## Stage 5 – Deploy

Application is released.

Examples:

```text
Development
Testing
Staging
Production
```

---

## Stage 6 – Monitor

Application health is monitored.

Examples:

```text
Logs
Metrics
Alerts
```

---

# CI Pipeline Example

```text
Developer
    ↓
Git Push
    ↓
Build
    ↓
Unit Tests
    ↓
Result
```

Purpose:

- Validate code changes

---

# CD Pipeline Example

```text
Build
   ↓
Test
   ↓
Deploy
   ↓
Production
```

Purpose:

- Deliver software to users

---

# GitHub Actions Pipeline Example

A workflow file:

```yaml
name: CI

on:
  push:

jobs:
  test:
    runs-on: ubuntu-latest

    steps:
      - run: echo "Building..."
      - run: echo "Testing..."
```

Pipeline flow:

```text
Git Push
    ↓
Workflow Triggered
    ↓
Job Starts
    ↓
Step 1: Build
    ↓
Step 2: Test
```

---

# Pipeline Failure

A failed pipeline is not a bad thing.

Example:

```text
Code
 ↓
Build
 ↓
Tests Fail
 ↓
Pipeline Stops
```

This prevents broken code from reaching production.

---

# Pipeline vs Workflow vs Job vs Step

| Term | Meaning |
|--------|---------|
| Pipeline | Entire automated process |
| Workflow | GitHub Actions automation file |
| Job | Group of related tasks |
| Step | Individual action inside a job |

Example:

```text
Pipeline
 └── Workflow
      └── Job
           ├── Step 1: Build
           ├── Step 2: Test
           └── Step 3: Deploy
```

---

# Key Takeaway

A pipeline is an automated sequence of stages that builds, tests, packages, and deploys software, helping teams deliver applications faster, more reliably, and with fewer errors.

## One-Line Definition for Notes

```text
A pipeline is an automated series of steps that moves code from development to production.
```
