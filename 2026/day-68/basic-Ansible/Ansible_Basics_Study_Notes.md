# Ansible Basics — Study Notes

## 1. What is Ansible?

**Ansible** is an **agentless automation and configuration-management tool** used to:

- Manage servers
- Install and configure software
- Deploy applications
- Automate repetitive administration tasks
- Manage infrastructure consistently

### Key Point

Ansible normally connects to Linux servers through **SSH**.

```text
Control Node
    |
    | SSH
    v
Managed Nodes
```

Ansible is called **agentless** because normally no Ansible agent needs to be installed on the managed servers.

---

## 2. Basic Ansible Architecture

```text
             +------------------+
             |   Control Node   |
             | Ansible Installed|
             +---------+--------+
                       |
                       | SSH
           +-----------+-----------+
           |           |           |
           v           v           v
        web01        web02        db01
      Managed Node Managed Node Managed Node
```

### Control Node

The **control node** is the machine where Ansible is installed and from where commands and playbooks are executed.

Example on RHEL/Fedora:

```bash
sudo dnf install ansible-core
```

Check the version:

```bash
ansible --version
```

### Managed Nodes

Managed nodes are the remote servers that Ansible controls.

Examples:

```text
web01
web02
db01
```

---

## 3. Inventory

The **inventory** tells Ansible which servers it should manage.

Example inventory file:

```ini
[webservers]
web01
web02

[database]
db01
```

You can also use IP addresses:

```ini
[webservers]
192.168.1.10
192.168.1.11
```

### Important

```text
Inventory = List of managed hosts
```

---

## 4. Ansible Modules

A **module** performs a specific task.

Common modules include:

- `ping` — test Ansible connectivity
- `package` — install/remove packages
- `service` — start/stop/restart services
- `copy` — copy files
- `file` — manage files/directories
- `user` — manage users
- `command` — run commands
- `shell` — run shell commands

### Ping Example

```bash
ansible all -m ping
```

Here:

```text
ansible   = Ansible command
all       = target all hosts
-m ping   = use the ping module
```

---

## 5. Ad-Hoc Commands

An **ad-hoc command** is used for a quick, one-time administrative task.

### Test Connectivity

```bash
ansible all -m ping
```

### Check Uptime

```bash
ansible all -a "uptime"
```

### Check Disk Space

```bash
ansible all -a "df -h"
```

### Install Apache

```bash
ansible all -m package -a "name=httpd state=present" -b
```

Explanation:

```text
-m package       = use package module
-a               = module arguments
name=httpd       = package name
state=present    = make sure it is installed
-b               = become/root privileges
```

### Restart Apache

```bash
ansible webservers -m service -a "name=httpd state=restarted" -b
```

---

## 6. Playbooks

A **playbook** is a YAML file containing automation instructions.

Example:

```yaml
---
- name: Install Apache
  hosts: webservers
  become: true

  tasks:
    - name: Install httpd
      package:
        name: httpd
        state: present

    - name: Start httpd
      service:
        name: httpd
        state: started
        enabled: true
```

Run the playbook:

```bash
ansible-playbook apache.yml
```

---

## 7. Playbook → Play → Task → Module

This hierarchy is very important:

```text
Playbook
   |
   +-- Play
         |
         +-- Task
               |
               +-- Module
```

Example:

```yaml
- name: Configure web server     # Play
  hosts: webservers

  tasks:
    - name: Install Apache        # Task
      package:                    # Module
        name: httpd
        state: present
```

---

## 8. Idempotency

**Idempotency** means Ansible tries to keep the system in the required or desired state without making unnecessary changes.

Example:

```yaml
package:
  name: httpd
  state: present
```

### First Run

```text
Apache is not installed
        |
        v
Ansible installs Apache
        |
        v
changed
```

### Second Run

```text
Apache is already installed
        |
        v
No change required
        |
        v
ok
```

### Key Point

```text
Same playbook + same desired state = no unnecessary changes
```

---

## 9. Variables

Variables help avoid hardcoding values.

Example:

```yaml
vars:
  package_name: httpd
```

Use the variable:

```yaml
tasks:
  - name: Install package
    package:
      name: "{{ package_name }}"
      state: present
```

---

## 10. Handlers

A **handler** normally runs only when another task notifies it.

Example:

```yaml
tasks:
  - name: Copy Apache configuration
    copy:
      src: httpd.conf
      dest: /etc/httpd/conf/httpd.conf
    notify: Restart Apache

handlers:
  - name: Restart Apache
    service:
      name: httpd
      state: restarted
```

### Why Use Handlers?

Apache restarts only if the configuration file actually changes.

---

## 11. Roles

**Roles** organize large Ansible projects into reusable components.

Example structure:

```text
roles/
└── webserver/
    ├── tasks/
    ├── handlers/
    ├── templates/
    ├── files/
    ├── vars/
    └── defaults/
```

### Advantages of Roles

- Better organization
- Reusable automation
- Easier maintenance
- Cleaner playbooks
- Useful for larger environments

---

## 12. Basic Ansible Workflow

```text
Inventory
   |
   v
Playbook
   |
   v
Hosts
   |
   v
Tasks
   |
   v
Modules
   |
   v
SSH
   |
   v
Linux Servers
```

Another way to remember it:

```text
Define Hosts
    ↓
Write Playbook
    ↓
Run Ansible
    ↓
Ansible Connects Through SSH
    ↓
Modules Execute Tasks
    ↓
Servers Reach Desired State
```

---

## 13. Important Ansible Commands

### Check Ansible Version

```bash
ansible --version
```

### Ping All Hosts

```bash
ansible all -m ping
```

### Ping One Group

```bash
ansible webservers -m ping
```

### Run a Linux Command

```bash
ansible all -a "uptime"
```

### Run With Sudo/Become

```bash
ansible all -a "whoami" -b
```

### Run a Playbook

```bash
ansible-playbook site.yml
```

### Check Playbook Syntax

```bash
ansible-playbook site.yml --syntax-check
```

### Dry Run / Check Mode

```bash
ansible-playbook site.yml --check
```

---

## 14. Ansible Keywords to Remember

| Term | Meaning |
|---|---|
| Control Node | Machine where Ansible is installed |
| Managed Node | Remote server managed by Ansible |
| Inventory | List of managed hosts |
| Module | Performs a particular operation |
| Task | Calls a module to perform work |
| Play | Applies tasks to selected hosts |
| Playbook | YAML file containing one or more plays |
| Variable | Stores reusable values |
| Handler | Runs when notified by another task |
| Role | Reusable structure for Ansible automation |
| Idempotency | Avoids unnecessary repeated changes |
| Become | Executes tasks with elevated privileges |
| SSH | Common connection method for Linux servers |

---

## 15. Ad-Hoc Command vs Playbook

| Ad-Hoc Command | Playbook |
|---|---|
| Quick one-time task | Repeatable automation |
| Command line | YAML file |
| Useful for troubleshooting | Useful for production automation |
| Simple tasks | Multiple structured tasks |
| Harder to reuse | Easy to reuse |

Example ad-hoc:

```bash
ansible webservers -m service -a "name=httpd state=restarted" -b
```

Equivalent idea in a playbook:

```yaml
- name: Restart Apache
  hosts: webservers
  become: true

  tasks:
    - name: Restart httpd
      service:
        name: httpd
        state: restarted
```

---

## 16. Interview Definition

A good basic interview answer:

> **Ansible is an agentless automation and configuration-management tool. It normally uses SSH to connect to Linux servers. Managed hosts are defined in an inventory, and repeatable automation is written in YAML playbooks using Ansible modules.**

---

## 17. Interview Topics to Know

Focus on these topics:

1. Inventory
2. Ad-hoc commands
3. Playbooks
4. YAML basics
5. Modules
6. Variables
7. Handlers
8. Roles
9. Idempotency
10. Become / privilege escalation
11. Ansible Vault
12. Templates
13. Facts
14. Conditionals
15. Loops

---

## 18. Quick Revision

```text
Ansible
  |
  +-- Agentless
  |
  +-- Uses SSH
  |
  +-- Control Node
  |
  +-- Managed Nodes
  |
  +-- Inventory
  |
  +-- Ad-Hoc Commands
  |
  +-- Playbooks
        |
        +-- Plays
              |
              +-- Tasks
                    |
                    +-- Modules
```

### Golden Line

```text
Inventory tells Ansible WHERE to work.
Playbook tells Ansible WHAT to do.
Modules perform the actual work.
SSH provides the connection.
```

---

# Next Learning Flow

```text
Ansible Basics
      ↓
Inventory
      ↓
Ad-Hoc Commands
      ↓
Playbooks
      ↓
Variables
      ↓
Conditionals & Loops
      ↓
Handlers
      ↓
Templates
      ↓
Roles
      ↓
Ansible Vault
      ↓
Ansible Automation Platform / Tower
```
