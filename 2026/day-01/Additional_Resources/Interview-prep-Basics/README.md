# Interview Prep Basics

A practical collection of **DevOps, Linux, and infrastructure interview-preparation notes** designed for quick revision, hands-on learning, and technical interview practice.

The repository includes **English study notes**, **Roman Urdu study notes**, and **visual infographics/posters** for commonly asked Linux and DevOps topics.

---

## Topics Covered

- Ansible
- Ansible Tower
- Docker
- Kubernetes
- Linux troubleshooting
- SSH
- CPU utilization and performance analysis
- Terraform

---

## Repository Structure

```text
Interview-prep-Basics/
├── basic-Ansible/
│   ├── Ansible-Basics-Automation.png
│   ├── Ansible_Basics_Study_Notes.md
│   ├── Ansible_Basics_Roman_Urdu_Study_Notes.md
│   └── Ansible-tower/
│
├── basics-docker/
│   ├── Docker-Beginner-Infographic.png
│   ├── Basic_Docker_Study_Notes.md
│   └── Basic_Docker_Roman_Urdu_Study_Notes.md
│
├── basics-K8s/
│   ├── Kubernetes-Basics-Infographic.png
│   ├── Kubernetes_Basics_Study_Notes_Updated_with_Volumes_and_Helm.md
│   └── Kubernetes_Basics_Roman_Urdu_Study_Notes_with_Volumes_and_Helm.md
│
├── basics-Linux/
│   ├── Safe-Linux-Disk-Space-Troubleshooting-Flow.png
│   ├── disk-full-df-vs-du.jpeg
│   ├── Linux-CPU-Utilization-yes-top-mpstat-Study-Notes.md
│   ├── Linux-CPU-Utilization-yes-top-mpstat-Study-Notes-Roman-Urdu.md
│   ├── SSH-From-Scratch-Advanced-DevOps.png
│   ├── SSH_From_Scratch_to_Advanced_Study_Notes.md
│   └── SSH_From_Scratch_to_Advanced_Study_Notes_Roman_Urdu.md
│
└── basics-teraform/
    ├── Terraform-Basics.png
    ├── Terraform_Basics_Study_Notes_English.md
    └── Terraform_Basics_Study_Notes_Roman_Urdu.md
```

---

## Ansible

Learn configuration management and automation using Ansible.

- [Ansible Basics — English](basic-Ansible/Ansible_Basics_Study_Notes.md)
- [Ansible Basics — Roman Urdu](basic-Ansible/Ansible_Basics_Roman_Urdu_Study_Notes.md)
- [Ansible Basics Infographic](basic-Ansible/Ansible-Basics-Automation.png)

### Ansible Tower

- [Ansible Tower — English](basic-Ansible/Ansible-tower/basic_ansible_tower_study_notes.md)
- [Ansible Tower — Roman Urdu](basic-Ansible/Ansible-tower/basic_ansible_tower_roman_urdu_study_notes.md)
- [Ansible Tower Infographic](basic-Ansible/Ansible-tower/Ansible-Tower-Basics.png)

---

## Docker

Beginner-friendly Docker notes covering containers, images, Dockerfiles, architecture, and common commands.

- [Docker Basics — English](basics-docker/Basic_Docker_Study_Notes.md)
- [Docker Basics — Roman Urdu](basics-docker/Basic_Docker_Roman_Urdu_Study_Notes.md)
- [Docker Beginner Infographic](basics-docker/Docker-Beginner-Infographic.png)

---

## Kubernetes

Kubernetes fundamentals for DevOps and production-support interview preparation.

Topics include cluster architecture, Control Plane, Worker Nodes, Pods, Deployments, Services, scaling, Volumes, and Helm.

- [Kubernetes Basics — English](basics-K8s/Kubernetes_Basics_Study_Notes_Updated_with_Volumes_and_Helm.md)
- [Kubernetes Basics — Roman Urdu](basics-K8s/Kubernetes_Basics_Roman_Urdu_Study_Notes_with_Volumes_and_Helm.md)
- [Kubernetes Infographic](basics-K8s/Kubernetes-Basics-Infographic.png)

---

## Linux

Practical Linux troubleshooting and performance-analysis material for system administration and production-support interviews.

### SSH

- [SSH From Scratch to Advanced — English](basics-Linux/SSH_From_Scratch_to_Advanced_Study_Notes.md)
- [SSH From Scratch to Advanced — Roman Urdu](basics-Linux/SSH_From_Scratch_to_Advanced_Study_Notes_Roman_Urdu.md)
- [SSH Infographic](basics-Linux/SSH-From-Scratch-Advanced-DevOps.png)

### CPU Utilization

Practice CPU troubleshooting using:

```bash
nproc
top
mpstat
yes
```

- [CPU Utilization Lab — English](basics-Linux/Linux-CPU-Utilization-yes-top-mpstat-Study-Notes.md)
- [CPU Utilization Lab — Roman Urdu](basics-Linux/Linux-CPU-Utilization-yes-top-mpstat-Study-Notes-Roman-Urdu.md)

### Disk Space Troubleshooting

- [Safe Disk Space Troubleshooting Flow](basics-Linux/Safe-Linux-Disk-Space-Troubleshooting-Flow.png)
- [Understanding df vs du](basics-Linux/disk-full-df-vs-du.jpeg)

Useful commands:

```bash
df -h
df -i
du -sh
find
lsof
```

---

## Terraform

Terraform fundamentals for Infrastructure as Code interview preparation.

Common workflow:

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

Resources:

- [Terraform Basics — English](basics-teraform/Terraform_Basics_Study_Notes_English.md)
- [Terraform Basics — Roman Urdu](basics-teraform/Terraform_Basics_Study_Notes_Roman_Urdu.md)
- [Terraform Infographic](basics-teraform/Terraform-Basics.png)

---

## Suggested Interview Revision Order

```text
Linux Basics
    ↓
SSH & Troubleshooting
    ↓
CPU / Disk Troubleshooting
    ↓
Docker
    ↓
Kubernetes
    ↓
Ansible
    ↓
Ansible Tower
    ↓
Terraform
```

---

## Interview Troubleshooting Flow

For production-support questions, try to structure answers like this:

```text
Problem
   ↓
Initial Checks
   ↓
Commands / Tools
   ↓
Observation
   ↓
Root Cause
   ↓
Fix
   ↓
Validation
   ↓
Prevention
```

Do not only memorize commands. Explain **why you are running each command and what you expect to find**.

---

## Languages

Most major topics are available in:

- **English** — for professional terminology and interview answers.
- **Roman Urdu** — for easier conceptual understanding.

---

## Goal

This repository is useful for preparation for roles such as:

- Linux System Administrator
- Linux Production Support Engineer
- DevOps Engineer
- Cloud / Infrastructure Engineer
- Platform Engineer
- Site Reliability / Operations Engineer

---

> **Learn the concept → Practice the command → Troubleshoot a scenario → Explain it in your own words.**