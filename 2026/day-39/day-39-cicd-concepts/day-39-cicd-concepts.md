# Day 39 – What is CI/CD?

# Automation:

Automation is the process of using technology to perform repetitive tasks automatically, reducing human effort, improving consistency, increasing speed, and minimizing errors.

[More Explanation](md/automation-notes.md)

# Pipeline:

A pipeline is an automated series of steps that moves code from development to production.

[More Explanation](md/pipeline-notes.md)


In DevOps, CI/CD is essentially automation applied to software delivery.

## Overview

CI/CD is a software development practice that automates the process of building, testing, and deploying applications.

Instead of manually checking code, running tests, and deploying applications, CI/CD pipelines automate these tasks to deliver software faster and more reliably.

CI/CD is a methodology, not a tool.

Examples of tools:

- GitHub Actions
- Jenkins
- GitLab CI/CD
- CircleCI
- Azure DevOps



---

# Learning Objectives

By the end of this day, I should be able to:

- Explain what CI/CD is
- Understand the problem CI/CD solves
- Differentiate between CI and CD
- Understand pipeline anatomy
- Read a basic CI/CD workflow
- Draw a CI/CD pipeline diagram
- Understand how modern teams deliver software

---

Table of Contents

| Section                      | Description                                      | Link                                                                 |
| ---------------------------- | ------------------------------------------------ | -------------------------------------------------------------------- |
| Overview                     | Introduction to CI/CD and Automation             | [Overview](#overview)                                                |
| Learning Objectives          | Goals for Day 39                                 | [Learning Objectives](#learning-objectives)                          |
| Automation                   | What Automation is and why it matters            | [Automation](#automation)                                            |
| Pipeline                     | What a Pipeline is and how it works              | [Pipeline](#pipeline)                                                |
| Task 1 – The Problem         | Problems teams face without CI/CD                | [Task 1](#task-1--the-problem)                                       |
| Task 1 Summary               | Key takeaways from the problem statement         | [Task 1 Summary](#task-1-summary)                                    |
| Task 2 – CI vs CD            | Continuous Integration, Delivery, and Deployment | [Task 2](#task-2-ci-vs-cd-complete-notes)                            |
| Continuous Integration (CI)  | Definition, workflow, and examples               | [CI](#continuous-integration-ci)                                     |
| Continuous Delivery          | Definition, workflow, and examples               | [Continuous Delivery](#continuous-delivery-cd)                       |
| Continuous Deployment        | Definition, workflow, and examples               | [Continuous Deployment](#continuous-deployment-cd)                   |
| CI/CD Comparison Table       | Compare CI, Delivery, and Deployment             | [Comparison](#comparison-table)                                      |
| Task 3 – Pipeline Anatomy    | Understanding pipeline components                | [Task 3](#day-39--task-3-pipeline-anatomy-professional-a-to-z-notes) |
| Trigger                      | What starts a pipeline                           | [Trigger](#1-trigger)                                                |
| Stage                        | Logical phases of a pipeline                     | [Stage](#2-stage)                                                    |
| Job                          | Major units of work                              | [Job](#3-job)                                                        |
| Step                         | Smallest unit of work                            | [Step](#4-step)                                                      |
| Runner                       | Machine that executes jobs                       | [Runner](#5-runner)                                                  |
| Artifact                     | Output produced by jobs                          | [Artifact](#6-artifact)                                              |
| Workflow vs Job vs Step      | Relationship between workflow components         | [Workflow vs Job vs Step](#workflow-vs-job-vs-step)                  |
| GitHub Actions Mapping       | Mapping pipeline concepts to GitHub Actions      | [GitHub Actions Mapping](#github-actions-mapping)                    |
| Pipeline Anatomy Diagram     | Complete CI/CD pipeline visualization            | [Pipeline Diagram](#complete-pipeline-anatomy-diagram)               |
| Interview Questions          | Common DevOps interview questions                | [Interview Questions](#common-interview-questions)                   |
| Task 4 – Draw a Pipeline     | Docker build and deployment pipeline             | [Task 4](#task-4-draw-a-pipeline)                                    |
| Pipeline Diagram             | Developer → Test → Build → Deploy                | [Pipeline Diagram](#a-pipeline)                                      |
| Task 5 – Explore in the Wild | Analysis of a real open-source workflow          | [Task 5](#task-5-explore-in-the-wild)                                |
| FastAPI Repository           | Selected open-source project                     | [FastAPI](#selected-repository)                                      |
| Workflow Analysis            | Trigger, Jobs, and Purpose                       | [Workflow Analysis](#task-3-what-does-it-do)                         |
| What I Learned               | Lessons from real-world CI/CD pipelines          | [What I Learned](#what-i-learned)                                    |
| Day 39 Summary               | Complete recap of Day 39                         | [Day 39 Summary](#day-39-summary)                                    |

---

# Day 39 Summary

| Topic                         | Key Learning                                                  |
| ----------------------------- | ------------------------------------------------------------- |
| Automation                    | Automates repetitive tasks and reduces human error            |
| Pipeline                      | Automated flow that moves code from development to production |
| CI                            | Automatically builds and tests code                           |
| Continuous Delivery           | Keeps software ready for release with manual approval         |
| Continuous Deployment         | Automatically deploys software after successful tests         |
| Trigger                       | Starts a workflow                                             |
| Stage                         | Logical phase of work                                         |
| Job                           | Group of related steps                                        |
| Step                          | Single command or action                                      |
| Runner                        | Machine executing jobs                                        |
| Artifact                      | Output generated by jobs                                      |
| GitHub Actions                | Tool used to implement CI/CD                                  |
| Pipeline Diagram              | Visual representation of software delivery                    |
| Open Source Workflow Analysis | Understanding real-world CI/CD pipelines                      |
| Self-Hosted Runner Connection | Applied CI/CD concepts on Ubuntu WSL ARM64                    |

```text
Day 39 Journey

Automation
     ↓
Pipeline
     ↓
The Problem
     ↓
CI vs CD
     ↓
Pipeline Anatomy
     ↓
Draw a Pipeline
     ↓
Explore Open Source Workflow
     ↓
Ready for GitHub Actions Pipelines
```

---

# Task 1 – The Problem

## Task Overview

Before understanding CI/CD, it is important to understand the challenges software teams face without automation.

Imagine a team of 5 developers working on the same application and manually deploying changes to production.

The goal of this task is to identify common problems and understand why CI/CD became necessary.

---

## Task Objective

After completing this task, I should be able to:

- Explain the risks of manual deployments
- Describe common software delivery problems
- Explain the meaning of "It Works on My Machine"
- Understand the limitations of manual deployment processes
- Explain why organizations adopt CI/CD practices

---

## Scenario

A team of 5 developers is working on the same application.

Each developer:

- Writes code
- Tests locally
- Pushes changes
- Deploys manually

There is no automation.

There are no automated tests.

There is no CI/CD pipeline.

---

## What Can Go Wrong?

### 1. Merge Conflicts

Two or more developers may modify the same files.

Result:

- Merge conflicts
- Lost code changes
- Broken functionality

---

### 2. Human Errors

Developers may:

- Forget to deploy files
- Deploy the wrong version
- Skip testing
- Use incorrect commands

Result:

- Application failures
- Service outages
- Customer impact

---

### 3. Environment Differences

Development, testing, and production systems may not be identical.

Examples:

- Different operating systems
- Different package versions
- Different configurations
- Missing dependencies

Result:

- Unexpected failures
- Difficult troubleshooting

---

### 4. Slow Releases

Manual deployments require significant effort.

Result:

- Delayed feature delivery
- Reduced productivity
- Increased deployment stress

---

### 5. Lack of Consistency

Every developer may follow a different deployment process.

Result:

- Unpredictable deployments
- Difficult troubleshooting
- Increased operational risk

---

## What Does "It Works on My Machine" Mean?

This phrase means:

> The application works correctly on the developer's computer but fails on another system.

---

## Why Does This Happen?

Common reasons:

- Different operating systems
- Different software versions
- Missing libraries
- Missing dependencies
- Different environment variables
- Different configurations

---

## Example

Developer Laptop:

```text
Python 3.13
```

Production Server:

```text
Python 3.10
```

The application may work perfectly on the developer's machine but fail in production.

---

## Why Is This A Real Problem?

Software must work consistently everywhere:

- Developer machine
- Test environment
- Staging environment
- Production environment

Without consistency:

- Bugs become difficult to reproduce
- Troubleshooting takes longer
- Releases become risky

CI/CD helps reduce these problems through automation and standardized processes.

---

## How Many Times Can A Team Safely Deploy Manually?

For most teams:

```text
1–2 deployments per day
```

is a realistic and safe limit.

Frequent manual deployments increase:

- Human error
- Downtime risk
- Rollback complexity

Organizations using CI/CD can deploy many times per day because the process is automated and validated.

Examples:

- 10+ deployments per day
- 100+ deployments per day
- 1000+ deployments per day

depending on the organization and automation maturity.

---

## Task 1 Summary

Without CI/CD:

- Deployments are slower
- Human errors increase
- Merge conflicts become common
- Environment differences cause failures
- Releases become risky

CI/CD was created to automate repetitive tasks, improve reliability, and help teams deliver software safely and consistently.

---

# Task 2: CI vs CD (Complete Notes)

## Overview
CI/CD is a modern software development practice that helps teams build, test, and deploy software quickly and reliably.

CI = Continuous Integration

CD can mean:
1. Continuous Delivery
2. Continuous Deployment

## Learning Objectives
- Define Continuous Integration (CI)
- Define Continuous Delivery (CD)
- Define Continuous Deployment (CD)
- Understand the differences between them
- Learn real-world examples

## Continuous Integration (CI)

### Definition
Continuous Integration (CI) is the practice of frequently merging code changes into a shared repository. Every change automatically triggers builds, tests, and validation checks to identify problems early.

### What Happens in CI?

```text
Developer Pushes Code
          ↓
Build Starts
          ↓
Tests Run
          ↓
Code Quality Checks
          ↓
Pass or Fail Result
```

### What Does CI Catch?
- Syntax errors
- Failed builds
- Unit test failures
- Dependency issues
- Merge conflicts
- Code quality problems

### Real-World Example
A developer pushes code to GitHub. GitHub Actions automatically builds the application, runs tests, and reports results.

---

## Continuous Delivery (CD)


### Definition
Continuous Delivery extends CI by ensuring that software is always in a deployable state. Production deployment still requires manual approval.

### What Does Delivery Mean?

```text
Ready for Release
```

### Workflow

```text
Code
 ↓
Build
 ↓
Test
 ↓
Package
 ↓
Manual Approval
 ↓
Production
```

### Real-World Example
A Docker image is built and stored in Docker Hub after successful tests. A release manager manually approves deployment.

---

## Continuous Deployment (CD)

### Definition
Continuous Deployment automatically deploys every change that passes all automated tests to production without human intervention.

### Workflow

```text
Code
 ↓
Build
 ↓
Test
 ↓
Package
 ↓
Automatic Deployment
 ↓
Production
```

### Real-World Example
A SaaS application automatically deploys to production after all tests pass.

---

## Comparison Table

| Feature | CI | Continuous Delivery | Continuous Deployment |
|----------|----|-------------------|----------------------|
| Build Automatically | Yes | Yes | Yes |
| Test Automatically | Yes | Yes | Yes |
| Production Deployment | No | Manual | Automatic |
| Human Approval | N/A | Yes | No |
| Purpose | Integrate Code | Release Ready | Auto Release |

---

## Visual Comparison

### CI

```text
Code
 ↓
Build
 ↓
Test
 ↓
Ready for Release
```

### Continuous Delivery

```text
Code
 ↓
Build
 ↓
Test
 ↓
Package
 ↓
Manual Approval
 ↓
Production
```

### Continuous Deployment

```text
Code
 ↓
Build
 ↓
Test
 ↓
Package
 ↓
Automatic Deployment
 ↓
Production
```

---

## GitHub Actions and CI/CD

GitHub Actions can be used for:

### CI
```text
Push → Build → Test
```

### Continuous Delivery
```text
Push → Build → Test → Package → Approval
```

### Continuous Deployment
```text
Push → Build → Test → Deploy Automatically
```

---

## Easy Way to Remember

```text
CI = Build and Test Automatically

Continuous Delivery = Build, Test, and Prepare for Release

Continuous Deployment = Build, Test, and Automatically Release
```

## Summary

CI finds problems early.

Continuous Delivery keeps software ready for release.

Continuous Deployment automatically releases software after all checks pass.

CI/CD is a practice and culture, not just a tool.

---

# Day 39 – Task 3: Pipeline Anatomy (Professional A-to-Z Notes)

# Overview

A CI/CD Pipeline is an automated sequence of processes that helps developers build, test, and deploy software quickly, consistently, and reliably.

Instead of manually performing repetitive tasks, a pipeline automates them, reducing human errors and improving software quality.

Modern DevOps teams use pipelines to:

- Build applications automatically
- Run tests automatically
- Perform security checks
- Create deployment packages
- Deploy applications
- Monitor software delivery

Popular CI/CD tools include:

- GitHub Actions
- Jenkins
- GitLab CI/CD
- CircleCI
- Azure DevOps
- TeamCity

---

# Learning Objectives

After completing this task, you should be able to:

- Define Pipeline
- Define Trigger
- Define Stage
- Define Job
- Define Step
- Define Runner
- Define Artifact
- Understand Pipeline Flow
- Understand Workflow vs Job vs Step
- Explain GitHub Actions pipeline anatomy
- Explain Self-Hosted Runners
- Answer common DevOps interview questions

---

# What is a Pipeline?

A pipeline is an automated workflow that performs a series of software delivery tasks.

Instead of manually building, testing, and deploying applications, a pipeline automates these activities.

## Traditional Process

```text
Developer Writes Code
         ↓
Build Manually
         ↓
Test Manually
         ↓
Deploy Manually
```

Problems:

- Human errors
- Slow delivery
- Inconsistent deployments
- Difficult troubleshooting

## Pipeline Approach

```text
Developer Pushes Code
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

- Faster delivery
- Consistent process
- Reduced errors
- Better software quality

---

# Pipeline Anatomy

Every CI/CD pipeline contains the following components:

```text
Trigger
   ↓
Stage
   ↓
Job
   ↓
Step
   ↓
Runner
   ↓
Artifact
```

Understanding these components is the foundation of DevOps automation.

---

# 1. Trigger

## Definition

A Trigger is an event that starts a pipeline.

Without a trigger, a pipeline will never run.

Think of a trigger as the ignition key of a car.

---

## Common Triggers

### Push Trigger

```yaml
on:
  push:
    branches:
      - main
```

Runs when code is pushed.

---

### Pull Request Trigger

```yaml
on:
  pull_request:
    branches:
      - main
```

Runs when a pull request is created.

---

### Manual Trigger

```yaml
on:
  workflow_dispatch:
```

Creates a Run Workflow button.

---

### Auto and Manual trigger

```yaml
on:
  push:
    branches:
      - main

  workflow_dispatch:
```

This means your workflow can run in two ways.

---

### Schedule Trigger

```yaml
on:
  schedule:
    - cron: '0 0 * * *'
```

Runs automatically based on a schedule.

---

## Real World Example

```text
Developer Pushes Code
         ↓
GitHub Actions Triggered
         ↓
Pipeline Starts
```

---

# 2. Stage

## Definition

A Stage is a logical phase inside a pipeline.

Stages help organize work into meaningful groups.

---

## Common Stages

### Build Stage

Creates application packages.

### Test Stage

Verifies application quality.

### Deploy Stage

Deploys software.

---

## Example

```text
Build
  ↓
Test
  ↓
Deploy
```

---

## Important GitHub Actions Note

GitHub Actions does not use the keyword "Stage".

Instead, stages are represented using multiple jobs.

Example:

```text
Job 1 = Build Stage

Job 2 = Test Stage

Job 3 = Deploy Stage
```

---

# 3. Job

## Definition

A Job is a collection of related steps executed on a runner.

Jobs represent major units of work.

---

## Example

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

  test:
    runs-on: ubuntu-latest

  deploy:
    runs-on: ubuntu-latest
```

---

## Job Dependencies

GitHub Actions uses:

```yaml
needs:
```

to control job order.

Example:

```yaml
jobs:
  build:
    runs-on: ubuntu-latest

  test:
    needs: build
    runs-on: ubuntu-latest

  deploy:
    needs: test
    runs-on: ubuntu-latest
```

Flow:

```text
Build
 ↓
Test
 ↓
Deploy
```

---

## Parallel Jobs

Without:

```yaml
needs:
```

jobs may run simultaneously.

Benefits:

- Faster execution
- Better resource usage

---

# 4. Step

## Definition

A Step is the smallest unit of work inside a job.

A job consists of one or more steps.

---

## Example

```yaml
steps:

- name: Checkout Code
  uses: actions/checkout@v4

- name: Run Tests
  run: pytest

- name: Build Application
  run: make build
```

---

## Real World Example

```text
Step 1 → Checkout Code

Step 2 → Install Dependencies

Step 3 → Run Tests

Step 4 → Build Application
```

---

# 5. Runner

## Definition

A Runner is the machine that executes jobs.

No Runner = No Job Execution

---

# Types of Runners

## GitHub Hosted Runner

GitHub provides:

- CPU
- Memory
- Storage
- Operating System

Example:

```yaml
runs-on: ubuntu-latest
```

Advantages:

- Easy setup
- No maintenance
- Scalable

Disadvantages:

- Limited customization
- Usage limits

---

## Self Hosted Runner

You provide your own machine.

Example:

```yaml
runs-on: [self-hosted, Linux, ARM64]
```

Advantages:

- Full control
- Custom software
- Internal network access

Disadvantages:

- Maintenance required
- Security responsibility

---

# Your Real Example

```text
khalid-wsl-runner
        ↓
Ubuntu 24.04 WSL2
        ↓
ARM64 Architecture
        ↓
Docker Jobs
        ↓
Ansible Jobs
```

This is a real-world DevOps project and a valuable resume point.

---

# 6. Artifact

## Definition

An Artifact is a file or output generated by a job.

Artifacts are used later by:

- Other jobs
- Deployment processes
- Team members

---

## Common Artifacts

- ZIP files
- Docker Images
- Test Reports
- HTML Reports
- Static Websites
- Log Files

---

## Example

```yaml
- name: Upload Artifact
  uses: actions/upload-artifact@v4
```

---

## Generic Example

```text
Build Application
        ↓
Create app.zip
        ↓
Upload Artifact
        ↓
Deploy Later
```

---

## Your Real Example

```text
Portfolio Files
(index.html, style.css, script.js)
                ↓
upload-pages-artifact
                ↓
Artifact Created
                ↓
deploy-pages
                ↓
Live Website
```

---

# Workflow vs Job vs Step

This is a common interview question.

## Structure

```text
Workflow
│
└── Job
    │
    ├── Step
    ├── Step
    └── Step
```

---

## Example

```text
Workflow: Deploy Portfolio
│
└── Job: Deploy
    │
    ├── Checkout Code
    ├── Setup GitHub Pages
    ├── Upload Artifact
    └── Deploy Website
```

---

# GitHub Actions Mapping

## Trigger

```yaml
on:
```

## Job

```yaml
jobs:
```

## Runner

```yaml
runs-on:
```

## Step

```yaml
steps:
```

## Artifact

```yaml
upload-artifact
```

---

# Complete Pipeline Anatomy Diagram

```text
Trigger
(Push / PR / Manual)
          │
          ▼
─────────────────────
       Pipeline
─────────────────────
          │
          ▼
      Stage 1
       Build
          │
          ▼
        Job
          │
          ▼
       Steps
 ┌────────────────┐
 │ Checkout Code │
 │ Install Tools │
 │ Build App     │
 └────────────────┘
          │
          ▼
      Artifact
     (app.zip)
          │
          ▼
      Stage 2
        Test
          │
          ▼
        Job
          │
          ▼
       Steps
 ┌────────────────┐
 │ Unit Tests     │
 │ Security Scan  │
 └────────────────┘
          │
          ▼
      Stage 3
       Deploy
          │
          ▼
        Job
          │
          ▼
       Steps
 ┌────────────────┐
 │ Deploy App     │
 │ Verify Site    │
 └────────────────┘
          │
          ▼
      Production

Runner Executes Every Job
```

---

# Real Examples From Day 39

## Portfolio Deployment

GitHub Actions automatically:

- Checks out code
- Uploads Pages artifact
- Deploys website

Result:

https://krmaryum.github.io/test-github-actions/

---

## Self Hosted Runner

You created:

```text
khalid-wsl-runner
```

Using:

```text
Ubuntu 24.04
WSL2
ARM64
```

---

## Docker Project

Pipeline executed:

```text
docker --version
docker run hello-world
docker ps
```

Successfully on your self-hosted runner.

---

## Ansible Project

Pipeline executed:

```text
ansible --version
touch /tmp/github-actions-ansible.txt
```

Successfully on your self-hosted runner.

---

# Common Interview Questions

## What is a Pipeline?

An automated workflow used to build, test, and deploy software.

---

## What is a Trigger?

An event that starts a pipeline.

---

## What is a Stage?

A logical phase of a pipeline.

---

## What is a Job?

A collection of related steps executed on a runner.

---

## What is a Step?

A single action or command inside a job.

---

## What is a Runner?

A machine that executes pipeline jobs.

---

## What is an Artifact?

A file or output generated by a job.

---

## Difference Between Job and Step?

A Job contains multiple Steps.

A Step is a single action.

---

## GitHub Hosted vs Self Hosted Runner?

GitHub Hosted:

- Managed by GitHub

Self Hosted:

- Managed by you

---

## Why Are Artifacts Important?

Artifacts preserve outputs between jobs and deployments.

---

## What is the difference between Checkout and Upload Artifact?

Checkout downloads repository files from GitHub to the runner.

Upload Artifact stores files produced or prepared by the job so they can be used later by another job or deployment step.

Checkout Code  = Get files

Upload Artifact = Save/Package files

# Key Takeaways

- Every pipeline starts with a trigger.
- Stages organize work.
- Jobs contain steps.
- Runners execute jobs.
- Artifacts store outputs.
- GitHub Actions uses jobs instead of stages.
- Self-hosted runners provide flexibility.
- Pipelines improve speed and reliability.

---

# Summary

Pipeline anatomy consists of Trigger, Stage, Job, Step, Runner, and Artifact.

Understanding these concepts is essential before building CI/CD pipelines because every GitHub Actions workflow, Jenkins pipeline, GitLab CI/CD configuration, and Azure DevOps pipeline is built from these core building blocks.

Mastering Pipeline Anatomy is the foundation for learning CI/CD and becoming a successful DevOps Engineer.

---

# Task 4: Draw a Pipeline

## A Pipeline:

```text
      Developer
          │
          ▼
  Push Code to GitHub
          │
          ▼
┌─────────────────────────┐
│ Stage 1: Test           │
│ - Checkout code         │
│ - Install dependencies  │
│ - Run unit tests        │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Stage 2: Build          │
│ - Build Docker image    │
│ - Tag Docker image      │
└───────────┬─────────────┘
            │
            ▼
┌─────────────────────────┐
│ Stage 3: Deploy         │
│ - Push image to registry│
│ - Deploy to staging     │
└───────────┬─────────────┘
            │
            ▼
      Staging Server
```

### Simple version for notebook

```text
Developer
     ↓
Push Code to GitHub
     ↓
Trigger Pipeline
     ↓
Stage 1: Test
     ↓
Stage 2: Build Docker Image
     ↓
Artifact (Docker Image)
     ↓
Stage 3: Deploy
     ↓
Staging Server
```

### Short explanation

This pipeline starts when a developer pushes code to GitHub. The pipeline first tests the application, then builds it into a Docker image, and finally deploys it to a staging server.

---

# Task 5: Explore in the Wild 

## Overview

One of the best ways to learn CI/CD is by studying real open-source projects and their GitHub Actions workflows.

## Selected Repository

Repository: FastAPI

GitHub:
https://github.com/fastapi/fastapi

Workflow File:

```text
.github/workflows/test.yml
```

## What is .github/workflows?

GitHub Actions workflows are stored in:

```text
.github/workflows/
```

Each YAML file defines:
- Triggers
- Jobs
- Steps
- Runners
- Artifacts

## About FastAPI

FastAPI is a modern Python web framework used for building APIs.

Features:
- High Performance
- Async Support
- Automatic API Documentation
- Production Ready

### Question 1: What Triggers It?

Example:

```yaml
on:
  push:
  pull_request:
```

### Push Trigger

```text
Developer Pushes Code
          ↓
Workflow Starts
```

### Pull Request Trigger

```text
Developer Opens Pull Request
          ↓
Workflow Starts
```

## Why Use Both?

Push:
- Validates code quickly

Pull Request:
- Validates code before merge

### Question 2: How Many Jobs Does It Have?

Typical jobs:

```text
Lint Job
     ↓
Test Job
     ↓
Compatibility Job
```
Note:
This is my best analysis of the workflow.

Actual job names may change as the project evolves.

Additional jobs in some projects:
- Security Scan
- Documentation Validation
- Package Build

## Understanding Each Job

### Lint Job

Checks:
- Formatting
- Style
- Code Quality

Tools:
- flake8
- black
- ruff

### Test Job

Runs:
- Unit Tests
- Integration Tests

### Compatibility Job

Tests:
- Python 3.10
- Python 3.11
- Python 3.12

### Question 3: What Does It Do?

Best Guess:

```text
Checkout Code
       ↓
Install Dependencies
       ↓
Run Lint Checks
       ↓
Run Tests
       ↓
Compatibility Checks
       ↓
Pass / Fail
```

## Pipeline Components

### Trigger

```yaml
on:
  push:
  pull_request:
```

### Jobs

```text
Lint
Test
Compatibility
```

### Steps

```text
Checkout Code
Install Dependencies
Run Tests
```

### Runner

```yaml
runs-on: ubuntu-latest
```

## Pipeline Diagram

```text
Push / Pull Request
          │
          ▼
      Trigger
          │
          ▼
      Lint Job
          │
          ▼
      Test Job
          │
          ▼
Compatibility Job
          │
          ▼
      Success
```

## Expanded Diagram

```text
Developer
     │
     ▼
Push Code / Pull Request
     │
     ▼
GitHub Actions Trigger
     │
     ▼
Checkout Code
     │
     ▼
Install Dependencies
     │
     ▼
Lint Checks
     │
     ▼
Run Tests
     │
     ▼
Compatibility Checks
     │
     ▼
Pass / Fail
```

## Why Open Source Projects Use CI/CD

Without CI/CD:
- Manual Testing
- Slower Releases
- Higher Risk

With CI/CD:
- Automated Testing
- Faster Feedback
- Better Quality

## Connection to My Projects

My Day 39 Projects:

```text
Portfolio Deployment
Self Hosted Runner
Docker Workflow
Ansible Workflow
```

FastAPI Uses:

```text
Automated Testing
Automated Validation
Automated Quality Checks
```

## What I Learned

- Open-source projects use CI/CD heavily.
- Most workflows use Push and Pull Request triggers.
- Pipelines contain multiple jobs.
- Testing is automated.
- Quality checks are automated.

## Interview Questions

### Why do open-source projects use CI/CD?

To automatically test and validate code before merging.

### What triggers most workflows?

Push and Pull Request events.

### Why run tests automatically?

To detect problems early.

### What happens if a job fails?

The workflow stops and reports failure.

## Key Takeaways

- Workflow files are stored in `.github/workflows`.
- Push and Pull Request are common triggers.
- Jobs organize work.
- Steps perform work.
- GitHub Actions improves software quality.

## Summary

We explored the FastAPI repository and reviewed a GitHub Actions workflow.

We identified:
- Workflow location
- Triggers
- Jobs
- Purpose

Studying open-source workflows is one of the best ways to learn practical CI/CD and GitHub Actions concepts.

---

Day 39 Summary

Today I learned:

✓ Why CI/CD exists
✓ Problems with manual deployments
✓ CI vs Continuous Delivery vs Continuous Deployment
✓ Pipeline Anatomy
✓ Trigger, Stage, Job, Step, Runner, Artifact
✓ GitHub Actions workflow structure
✓ How real open-source projects use CI/CD
✓ How to draw and understand pipelines

This knowledge forms the foundation for creating GitHub Actions workflows in upcoming lessons.


