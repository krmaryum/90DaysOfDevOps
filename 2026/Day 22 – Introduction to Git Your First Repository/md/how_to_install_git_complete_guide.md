# Complete Guide: How to Install Git (A to Z)

Author: Khalid Khan

---

# Overview

Git is a distributed version control system used to track changes in files and projects.

Git is one of the most important tools in:
- DevOps
- software engineering
- CI/CD pipelines
- automation
- Infrastructure as Code
- team collaboration

---

# What Is Git?

Git is a version control system.

It tracks:
- file changes
- project history
- commits
- branches
- collaboration updates

Git stores snapshots of your project over time.

---

# Why Git Is Important

Git is used in almost every DevOps workflow.

Git is used for:
- application source code
- Kubernetes manifests
- Docker projects
- automation scripts
- CI/CD pipelines

Popular platforms using Git:
- GitHub
- GitLab
- Bitbucket

---

# Install Git on Windows

## Step 1 — Download Git

Open:

https://git-scm.com/download/win

Git download should start automatically.

---

# Step 2 — Run the Installer

Open downloaded installer.

Example:

```text
Git-2.xx.x-64-bit.exe
```

---

# Step 3 — Follow Installation Wizard

Recommended:
- keep default settings
- click Next
- continue installation

Important option:

```text
Git from the command line and also from 3rd-party software
```

Keep this selected.

---

# Step 4 — Complete Installation

Click:

```text
Finish
```

Git is now installed.

---

# Verify Git Installation on Windows

Open:
- PowerShell
- CMD
- Git Bash

Run:

```bash
git --version
```

Example output:

```text
git version 2.54.0
```

Meaning:
- Git installed successfully

---

# Install Git on Ubuntu / WSL

## Step 1 — Update Package List

Run:

```bash
sudo apt update
```

---

## Step 2 — Install Git

Run:

```bash
sudo apt install git -y
```

---

## Step 3 — Verify Installation

Run:

```bash
git --version
```

Example output:

```text
git version 2.54.0
```

---

# Install Git on CentOS / RHEL

Run:

```bash
sudo yum install git -y
```

or newer systems:

```bash
sudo dnf install git -y
```

---

# Install Git on macOS

## Using Homebrew

Run:

```bash
brew install git
```

---

# Verify Installation

Run:

```bash
git --version
```

---

# Configure Git After Installation

Git should be configured with:
- username
- email

These details appear in commits.

---

# Set Git Username

Run:

```bash
git config --global user.name "Your Name"
```

Example:

```bash
git config --global user.name "username"
```

---

# Set Git Email

Run:

```bash
git config --global user.email "user@example.com"
```

Example:

```bash
git config --global user.email "example@yahoo.com"
```

---

# Verify Git Configuration

Run:

```bash
git config --global --list
```

Example output:

```text
user.name=krmaryum
user.email=krmaryum@yahoo.com
```

---

# Test Git Installation

## Step 1 — Create Folder

Run:

```bash
mkdir git-test
```

---

## Step 2 — Enter Folder

Run:

```bash
cd git-test
```

---

## Step 3 — Initialize Git Repository

Run:

```bash
git init
```

Example output:

```text
Initialized empty Git repository
```

Meaning:
- Git repository created successfully

---

# What git init Creates

Git creates:

```text
.git/
```

hidden directory.

This folder stores:
- commit history
- branches
- repository metadata
- configuration
- Git objects

---

# Check Hidden Files

Run:

```bash
ls -al
```

Example output:

```text
.git
```

Meaning:
- Git repository exists

---

# Check Git Repository Status

Run:

```bash
git status
```

Example output:

```text
On branch main

No commits yet
```

Meaning:
- repository exists
- no commits created yet

---

# Understanding Git Workflow

Git workflow:

```text
Working Directory
        ↓
git add
        ↓
Staging Area
        ↓
git commit
        ↓
Repository History
```

---

# Important Git Commands

| Command | Purpose |
|---|---|
| `git --version` | check installed version |
| `git init` | initialize repository |
| `git status` | check repository status |
| `git add` | stage files |
| `git commit` | create snapshot |
| `git log` | view history |
| `git config` | configure Git |

---

# Connect Git with GitHub

Git works locally.

GitHub stores repositories online.

To connect GitHub:

```bash
git remote add origin git@github.com:username/repository.git
```

---

# Verify Remote Repository

Run:

```bash
git remote -v
```

Example:

```text
origin  git@github.com:user/repo.git (fetch)
origin  git@github.com:user/repo.git (push)
```

---

# Push Code to GitHub

Run:

```bash
git push -u origin main
```

Meaning:
- uploads commits to GitHub

---

# Common Problems and Fixes

## Git Command Not Found

Problem:

```text
git: command not found
```

Fix:
- reinstall Git
- restart terminal
- ensure Git added to PATH

---

# Permission Denied Publickey

Problem:

```text
Permission denied (publickey)
```

Fix:
- configure SSH key
- add SSH key to GitHub
- test using:

```bash
ssh -T git@github.com
```

---

# No Configured Push Destination

Problem:

```text
fatal: No configured push destination
```

Fix:

```bash
git remote add origin <repository-url>
```

---

# Real DevOps Importance

Git is the backbone of DevOps.

Git integrates with:
- Jenkins
- GitHub Actions
- Kubernetes
- Docker
- Terraform
- Ansible
- CI/CD pipelines

Every DevOps engineer uses Git daily.

---

# Final Understanding

Installing Git involves:

1. downloading Git
2. installing Git
3. verifying installation
4. configuring username/email
5. testing repository creation
6. connecting GitHub

After installation, Git becomes ready for:
- version control
- collaboration
- GitHub workflows
- DevOps automation
