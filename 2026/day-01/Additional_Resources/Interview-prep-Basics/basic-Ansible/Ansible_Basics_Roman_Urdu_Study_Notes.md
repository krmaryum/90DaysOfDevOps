# Ansible Basics — Roman Urdu Study Notes

## 1. Ansible kya hai?

**Ansible** ek **agentless automation aur configuration-management tool** hai jo in kaamon ke liye use hota hai:

- Servers manage karna
- Software install aur configure karna
- Applications deploy karna
- Repetitive administration tasks automate karna
- Infrastructure ko consistent rakhna

### Key Point

Ansible aam tor par Linux servers se **SSH** ke zariye connect karta hai.

```text
Control Node
    |
    | SSH
    v
Managed Nodes
```

Ansible ko **agentless** is liye kaha jata hai kyun ke managed servers par aam tor par Ansible agent install karne ki zaroorat nahi hoti.

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

**Control Node** wo machine hoti hai jahan Ansible install hota hai aur jahan se hum commands aur playbooks run karte hain.

RHEL/Fedora par example:

```bash
sudo dnf install ansible-core
```

Version check karne ke liye:

```bash
ansible --version
```

### Managed Nodes

**Managed Nodes** wo remote servers hote hain jin ko Ansible manage karta hai.

Examples:

```text
web01
web02
db01
```

---

## 3. Inventory

**Inventory** Ansible ko batata hai ke kin servers ko manage karna hai.

Example inventory file:

```ini
[webservers]
web01
web02

[database]
db01
```

Aap IP addresses bhi use kar sakte hain:

```ini
[webservers]
192.168.1.10
192.168.1.11
```

### Important

```text
Inventory = Managed hosts ki list
```

---

## 4. Ansible Modules

**Module** ek specific task perform karta hai.

Common modules:

- `ping` — Ansible connectivity check karta hai
- `package` — package install/remove karta hai
- `service` — service start/stop/restart karta hai
- `copy` — files copy karta hai
- `file` — files/directories manage karta hai
- `user` — users manage karta hai
- `command` — commands run karta hai
- `shell` — shell commands run karta hai

### Ping Example

```bash
ansible all -m ping
```

Yahan:

```text
ansible   = Ansible command
all       = sab hosts ko target karo
-m ping   = ping module use karo
```

---

## 5. Ad-Hoc Commands

**Ad-hoc command** ek quick aur one-time administrative task ke liye use hota hai.

### Connectivity Check

```bash
ansible all -m ping
```

### Uptime Check

```bash
ansible all -a "uptime"
```

### Disk Space Check

```bash
ansible all -a "df -h"
```

### Apache Install Karna

```bash
ansible all -m package -a "name=httpd state=present" -b
```

Explanation:

```text
-m package       = package module use karo
-a               = module arguments
name=httpd       = package ka naam
state=present    = ensure karo ke package installed ho
-b               = become/root privileges
```

### Apache Restart Karna

```bash
ansible webservers -m service -a "name=httpd state=restarted" -b
```

---

## 6. Playbooks

**Playbook** ek YAML file hoti hai jisme automation instructions hoti hain.

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

Playbook run karne ke liye:

```bash
ansible-playbook apache.yml
```

---

## 7. Playbook → Play → Task → Module

Yeh hierarchy interview ke liye bohat important hai:

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

**Idempotency** ka matlab hai ke Ansible system ko required ya desired state mein rakhta hai aur unnecessary changes repeat nahi karta.

Example:

```yaml
package:
  name: httpd
  state: present
```

### First Run

```text
Apache installed nahi hai
        |
        v
Ansible Apache install karta hai
        |
        v
changed
```

### Second Run

```text
Apache pehle se installed hai
        |
        v
Koi change required nahi
        |
        v
ok
```

### Key Point

```text
Same playbook + same desired state = unnecessary changes nahi
```

---

## 9. Variables

Variables hardcoding ko avoid karne mein help karti hain.

Example:

```yaml
vars:
  package_name: httpd
```

Variable ko use karna:

```yaml
tasks:
  - name: Install package
    package:
      name: "{{ package_name }}"
      state: present
```

---

## 10. Handlers

**Handler** aam tor par tab run hota hai jab koi doosra task usay notify kare.

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

### Handlers kyun use karte hain?

Apache sirf tab restart hoga jab configuration file waqai change ho.

---

## 11. Roles

**Roles** large Ansible projects ko reusable aur organized structure mein divide karte hain.

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

### Roles ke faide

- Better organization
- Reusable automation
- Easy maintenance
- Cleaner playbooks
- Large environments ke liye useful

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

Isko is tarah bhi yaad rakh sakte hain:

```text
Hosts define karo
    ↓
Playbook likho
    ↓
Ansible run karo
    ↓
Ansible SSH se connect karega
    ↓
Modules tasks execute karenge
    ↓
Servers desired state mein aa jayenge
```

---

## 13. Important Ansible Commands

### Ansible Version Check

```bash
ansible --version
```

### Sab Hosts ko Ping Karna

```bash
ansible all -m ping
```

### Ek Group ko Ping Karna

```bash
ansible webservers -m ping
```

### Linux Command Run Karna

```bash
ansible all -a "uptime"
```

### Sudo/Become ke Saath Command

```bash
ansible all -a "whoami" -b
```

### Playbook Run Karna

```bash
ansible-playbook site.yml
```

### Playbook Syntax Check

```bash
ansible-playbook site.yml --syntax-check
```

### Dry Run / Check Mode

```bash
ansible-playbook site.yml --check
```

---

## 14. Ansible Keywords Yaad Rakhein

| Term | Roman Urdu Meaning |
|---|---|
| Control Node | Machine jahan Ansible install hota hai |
| Managed Node | Remote server jo Ansible manage karta hai |
| Inventory | Managed hosts ki list |
| Module | Specific operation perform karta hai |
| Task | Module ko call karke kaam karwata hai |
| Play | Selected hosts par tasks apply karta hai |
| Playbook | YAML file jisme ek ya zyada plays hote hain |
| Variable | Reusable values store karti hai |
| Handler | Notify hone par run hota hai |
| Role | Reusable Ansible structure |
| Idempotency | Unnecessary repeated changes ko avoid karna |
| Become | Elevated privileges ke saath task run karna |
| SSH | Linux servers ke liye common connection method |

---

## 15. Ad-Hoc Command vs Playbook

| Ad-Hoc Command | Playbook |
|---|---|
| Quick one-time task | Repeatable automation |
| Command line se run hota hai | YAML file hoti hai |
| Troubleshooting mein useful | Production automation mein useful |
| Simple tasks ke liye | Multiple structured tasks ke liye |
| Reuse mushkil | Reuse easy |

Ad-hoc example:

```bash
ansible webservers -m service -a "name=httpd state=restarted" -b
```

Isi ka playbook idea:

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

Interview mein aap is tarah bata sakte hain:

> **Ansible ek agentless automation aur configuration-management tool hai. Yeh aam tor par SSH ke zariye Linux servers se connect karta hai. Managed hosts inventory mein define kiye jate hain, aur repeatable automation YAML playbooks mein Ansible modules ke through likhi jati hai.**

---

## 17. Interview ke Liye Important Topics

In topics par focus karein:

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
  +-- SSH use karta hai
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
Inventory Ansible ko batata hai WHERE kaam karna hai.
Playbook Ansible ko batata hai WHAT karna hai.
Modules actual kaam perform karte hain.
SSH connection provide karta hai.
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
