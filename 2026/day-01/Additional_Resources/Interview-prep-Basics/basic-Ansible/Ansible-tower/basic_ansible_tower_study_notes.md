# Basic Ansible Tower — Study Notes

## 1. What is Ansible Tower?

Ansible Tower is a centralized platform used to run and manage Ansible automation through a web-based interface.

It provides:

- Web GUI
- Centralized automation control
- Scheduling
- Role-Based Access Control (RBAC)
- Credential management
- Job monitoring
- Reporting
- Workflow automation

> **Note:** Ansible Tower is now known as **Automation Controller** and is part of **Red Hat Ansible Automation Platform (AAP)**.

---

## 2. Simple Architecture

```text
User
  |
  v
Ansible Tower
  |
  v
Ansible Playbook
  |
  v
Managed Linux Servers
```

Ansible Tower normally connects to Linux servers using **SSH**.

In most cases, no Ansible agent needs to be installed on the managed servers.

---

## 3. Core Components

### Inventory

Inventory contains the servers or groups of servers that Ansible Tower will manage.

Example:

```text
web01
web02
app01
db01
```

You can also organize hosts into groups:

```text
[webservers]
web01
web02

[databases]
db01
```

---

### Credentials

Credentials allow Tower to authenticate to managed systems.

Examples:

- SSH username/password
- SSH private key
- Sudo / privilege escalation credentials
- AWS credentials
- Cloud credentials

---

### Project

A Project contains or connects to Ansible playbooks.

Projects are commonly synchronized from source control systems such as:

- Git
- GitHub
- GitLab
- Bitbucket

Example:

```text
Git Repository
     |
     v
Ansible Tower Project
     |
     v
patch.yml
deploy.yml
restart_service.yml
```

---

### Job Template

A Job Template combines the information needed to run automation.

Usually it includes:

```text
Inventory
   +
Credentials
   +
Project
   +
Playbook
   =
Job Template
```

Example:

```text
Job Template: Monthly Linux Patching
Inventory: Production Linux Servers
Credential: Linux SSH Key
Project: Linux-Automation
Playbook: patch.yml
```

---

### Job

A **Job** is the actual execution of a Job Template.

Example:

```text
Job Template
     |
     v
Launch
     |
     v
Job Running
     |
     v
Success / Failed
```

---

### Schedule

Schedules allow jobs to run automatically at specific times.

Example:

```text
Monthly Linux Patching
Every Saturday
11:00 PM
```

Useful for:

- Patching
- Backups
- Health checks
- Compliance checks
- Regular maintenance

---

### RBAC

RBAC stands for:

**Role-Based Access Control**

It controls who can:

- View jobs
- Run jobs
- Edit templates
- Manage inventories
- Manage credentials
- Administer Tower

Example:

```text
Linux Team     -> Run patching jobs
Developer Team -> View deployment jobs
Admin Team     -> Full access
```

---

### Workflow Template

A Workflow Template connects multiple Job Templates together.

Example:

```text
Backup
   |
   v
Patch Servers
   |
   v
Reboot
   |
   v
Health Check
```

This is useful when several automation steps must run in a specific order.

---

## 4. Basic Ansible Tower Workflow

A simple flow to remember:

```text
Inventory
   |
   v
Credentials
   |
   v
Project
   |
   v
Job Template
   |
   v
Launch
   |
   v
Monitor
```

### Easy Memory Line

**Inventory -> Credentials -> Project -> Job Template -> Launch -> Monitor**

---

## 5. Example: Linux Patching

Suppose you need to patch 100 RHEL servers.

Instead of logging in to every server manually:

### Step 1 — Create Inventory

Add the Linux servers:

```text
server01
server02
server03
...
server100
```

### Step 2 — Add Credentials

Configure the SSH credential used to connect to the servers.

### Step 3 — Create Project

Sync the Ansible playbooks from Git.

Example:

```text
patch.yml
```

### Step 4 — Create Job Template

Configure:

```text
Inventory: Production Servers
Credential: Linux SSH
Project: Linux Automation
Playbook: patch.yml
```

### Step 5 — Launch Job

Run the Job Template manually or through a schedule.

### Step 6 — Monitor Results

Tower shows which servers succeeded or failed.

Example:

```text
PLAY RECAP

server01 : ok=10 changed=4 failed=0
server02 : ok=10 changed=4 failed=0
server03 : ok=8  changed=2 failed=1
```

---

## 6. Why Use Ansible Tower?

### Centralized Automation

Manage automation for many servers from one location.

### GUI

Users do not always need to run Ansible commands manually from the CLI.

### Scheduling

Jobs can run automatically at configured times.

### Credential Management

Credentials can be stored and managed securely.

### RBAC

Control who can run or modify automation.

### Monitoring

View job status and execution output from the dashboard.

### Workflows

Chain multiple automation jobs together.

### Consistency

The same playbooks and processes can be executed across many systems.

---

## 7. Ansible Core vs Ansible Tower

| Feature | Ansible Core | Ansible Tower |
|---|---|---|
| Interface | CLI | Web GUI + API |
| Inventory | Yes | Yes |
| Playbooks | Yes | Yes |
| Scheduling | Limited/manual | Built-in |
| RBAC | No built-in enterprise RBAC | Yes |
| Credential Management | Manual/files | Centralized |
| Job Monitoring | CLI output | Dashboard |
| Workflow Automation | Manual | Built-in |
| Team Access | Limited | Strong RBAC |
| Reporting | Basic | Centralized |

---

## 8. Common Use Cases

Ansible Tower can be used for:

- Linux patching
- Package installation
- User management
- Service restart
- Configuration deployment
- Security hardening
- Application deployment
- Health checks
- Server provisioning
- AWS automation
- Compliance automation
- Backup tasks

---

## 9. Interview Answer

### Short Answer

> Ansible Tower is a centralized platform for managing Ansible automation. It provides a web UI, inventory management, credential management, job templates, scheduling, RBAC, workflows, and centralized job monitoring.

### Practical Answer

> In a Linux environment, we can use Ansible Tower to manage automation across many servers. For example, for monthly RHEL patching, we can create an inventory of servers, configure SSH credentials, sync the patching playbook from Git, create a Job Template, schedule it during the maintenance window, and monitor the results from the Tower dashboard.

---

## 10. Important Interview Terms

### Inventory
List of managed hosts and groups.

### Credential
Authentication information used by Tower.

### Project
Source of Ansible playbooks, usually Git.

### Job Template
Reusable configuration used to run a playbook.

### Job
Actual execution of a Job Template.

### Schedule
Runs jobs automatically at specified times.

### RBAC
Controls user and team permissions.

### Workflow
Connects multiple Job Templates together.

---

## 11. Quick Revision

```text
Ansible Core = CLI Automation

Ansible Tower = Centralized Ansible Management

Tower provides:
- GUI
- Inventory
- Credentials
- Projects
- Job Templates
- Scheduling
- RBAC
- Workflows
- Monitoring
- Reporting
```

### Most Important Flow

```text
Inventory
   ->
Credentials
   ->
Project
   ->
Job Template
   ->
Launch
   ->
Monitor
```

---

## 12. One-Line Memory Tip

**Ansible Tower helps teams centrally control, schedule, secure, execute, and monitor Ansible automation across multiple systems.**
