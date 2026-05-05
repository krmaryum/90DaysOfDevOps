# 📘 Multi-Play Ansible Playbook Explanation

This playbook has 3 separate plays, each targeting a different server group.

## YAML Start

`---` marks the beginning of the YAML file.

---

## 🔹 Play 1: Configure Web Servers

- **hosts:** ubuntu_web  
- **become:** true (run with sudo)

### Tasks:
- Install Nginx using `apt`
- Start and enable Nginx service

---

## 🔹 Play 2: Configure App Servers

- **hosts:** redhat_app  
- **become:** true

### Tasks:
- Install build dependencies (`gcc`, `make`) using `yum`
- Create application directory `/opt/app` with proper permissions

It installs:

- gcc → compiler
- make → build automation tool

These are needed when compiling or building applications.

---

## 🔹 Play 3: Configure Database Servers

- **hosts:** amz_db  
- **become:** true

### Tasks:
- Install MariaDB client using `yum`
- Create secure data directory `/var/lib/appdata` with restricted permissions

---

## 🧠 Key Concepts

- **Multiple Plays:** One playbook can target different server groups
- **OS-specific modules:** 
  - `apt` → Ubuntu/Debian  
  - `yum` → RedHat/Amazon Linux  
- **Idempotency:** Tasks run safely multiple times without breaking state
- **Service Management:** Ensures services are running and enabled
- **File Module:** Used for creating directories and managing permissions

---

## 📌 Summary

This playbook configures 3 types of servers:
- Configures web servers with Nginx
- Prepares app servers with build tools
- Sets up database servers with required client and directories

| Server group | OS type      | What it does                                           |
| ------------ | ------------ | ------------------------------------------------------ |
| `ubuntu_web` | Ubuntu       | Installs and starts Nginx                              |
| `redhat_app` | RedHat       | Installs build tools and creates app folder            |
| `amz_db`     | Amazon Linux | Installs MariaDB client and creates secure data folder |

> t is a multi-play Ansible playbook for managing different server roles.

> It demonstrates real-world DevOps automation across multiple environments.
