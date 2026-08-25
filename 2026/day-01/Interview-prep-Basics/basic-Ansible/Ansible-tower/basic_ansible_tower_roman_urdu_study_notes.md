# Basic Ansible Tower — Roman Urdu Study Notes

## 1. Ansible Tower kya hai?

Ansible Tower ek centralized platform hai jo Ansible automation ko web-based interface ke zariye run aur manage karne ke liye use hota hai.

Yeh provide karta hai:

- Web GUI
- Centralized automation control
- Scheduling
- Role-Based Access Control (RBAC)
- Credential management
- Job monitoring
- Reporting
- Workflow automation

> **Note:** Ansible Tower ko ab **Automation Controller** kaha jata hai aur yeh **Red Hat Ansible Automation Platform (AAP)** ka hissa hai.

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

Ansible Tower aam tor par Linux servers ke saath **SSH** ke zariye connect karta hai.

Zyada tar cases mein managed servers par Ansible agent install karne ki zarurat nahi hoti.

---

## 3. Core Components

### Inventory

Inventory mein un servers ya server groups ki list hoti hai jinhein Ansible Tower manage karega.

Example:

```text
web01
web02
app01
db01
```

Hosts ko groups mein bhi organize kiya ja sakta hai:

```text
[webservers]
web01
web02

[databases]
db01
```

---

### Credentials

Credentials Tower ko managed systems ke saath authenticate karne ke liye use hoti hain.

Examples:

- SSH username/password
- SSH private key
- Sudo / privilege escalation credentials
- AWS credentials
- Cloud credentials

---

### Project

Project mein Ansible playbooks hotay hain ya source control se sync hotay hain.

Projects aam tor par in systems se sync kiye jate hain:

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

Job Template woh reusable configuration hoti hai jo automation run karne ke liye zaruri cheezen combine karti hai.

Aam tor par is mein hota hai:

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

**Job** Job Template ka actual execution hota hai.

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

Schedule ke zariye jobs ko specific time par automatically run karwaya ja sakta hai.

Example:

```text
Monthly Linux Patching
Har Saturday
11:00 PM
```

Yeh useful hota hai:

- Patching
- Backups
- Health checks
- Compliance checks
- Regular maintenance

---

### RBAC

RBAC ka matlab hai:

**Role-Based Access Control**

Yeh control karta hai ke kaun:

- Jobs dekh sakta hai
- Jobs run kar sakta hai
- Templates edit kar sakta hai
- Inventories manage kar sakta hai
- Credentials manage kar sakta hai
- Tower administer kar sakta hai

Example:

```text
Linux Team     -> Patching jobs run kar sakti hai
Developer Team -> Deployment jobs dekh sakti hai
Admin Team     -> Full access
```

---

### Workflow Template

Workflow Template multiple Job Templates ko ek sequence mein connect karta hai.

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

Yeh tab useful hota hai jab kai automation steps ko ek specific order mein run karna ho.

---

## 4. Basic Ansible Tower Workflow

Yaad rakhne ke liye simple flow:

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

Maan lein aapko 100 RHEL servers patch karne hain.

Har server par manually login karne ke bajaye:

### Step 1 — Inventory Create Karein

Linux servers add karein:

```text
server01
server02
server03
...
server100
```

### Step 2 — Credentials Add Karein

SSH credential configure karein jo servers se connect hone ke liye use hogi.

### Step 3 — Project Create Karein

Git se Ansible playbooks sync karein.

Example:

```text
patch.yml
```

### Step 4 — Job Template Create Karein

Configure karein:

```text
Inventory: Production Servers
Credential: Linux SSH
Project: Linux Automation
Playbook: patch.yml
```

### Step 5 — Job Launch Karein

Job Template ko manually run karein ya schedule ke zariye.

### Step 6 — Results Monitor Karein

Tower dikhata hai ke kaun se servers successful thay aur kaun se fail huay.

Example:

```text
PLAY RECAP

server01 : ok=10 changed=4 failed=0
server02 : ok=10 changed=4 failed=0
server03 : ok=8  changed=2 failed=1
```

---

## 6. Ansible Tower kyun use karte hain?

### Centralized Automation

Bohat se servers ki automation ek central jagah se manage ki ja sakti hai.

### GUI

Har user ko Ansible CLI commands manually run karne ki zarurat nahi hoti.

### Scheduling

Jobs ko configured time par automatically run kar sakte hain.

### Credential Management

Credentials ko centrally aur securely manage kiya ja sakta hai.

### RBAC

Control kar sakte hain ke kaun automation run ya modify kar sakta hai.

### Monitoring

Dashboard se job status aur execution output dekha ja sakta hai.

### Workflows

Multiple automation jobs ko ek sequence mein run kar sakte hain.

### Consistency

Same playbooks aur processes ko bohat se systems par consistently execute kiya ja sakta hai.

---

## 7. Ansible Core vs Ansible Tower

| Feature | Ansible Core | Ansible Tower |
|---|---|---|
| Interface | CLI | Web GUI + API |
| Inventory | Haan | Haan |
| Playbooks | Haan | Haan |
| Scheduling | Limited/manual | Built-in |
| RBAC | Built-in enterprise RBAC nahi | Haan |
| Credential Management | Manual/files | Centralized |
| Job Monitoring | CLI output | Dashboard |
| Workflow Automation | Manual | Built-in |
| Team Access | Limited | Strong RBAC |
| Reporting | Basic | Centralized |

---

## 8. Common Use Cases

Ansible Tower ko in kaamon ke liye use kiya ja sakta hai:

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

> Ansible Tower ek centralized platform hai jo Ansible automation ko manage karne ke liye use hota hai. Is mein web UI, inventory management, credential management, job templates, scheduling, RBAC, workflows aur centralized job monitoring hoti hai.

### Practical Answer

> Linux environment mein hum Ansible Tower ko bohat se servers par automation manage karne ke liye use kar sakte hain. Misal ke taur par monthly RHEL patching ke liye hum servers ki inventory banate hain, SSH credentials configure karte hain, Git se patching playbook sync karte hain, Job Template create karte hain, maintenance window mein schedule karte hain, aur Tower dashboard se results monitor karte hain.

---

## 10. Important Interview Terms

### Inventory
Managed hosts aur groups ki list.

### Credential
Authentication information jo Tower use karta hai.

### Project
Ansible playbooks ka source, aam tor par Git.

### Job Template
Reusable configuration jo playbook run karne ke liye use hoti hai.

### Job
Job Template ka actual execution.

### Schedule
Job ko specific time par automatically run karta hai.

### RBAC
User aur team permissions control karta hai.

### Workflow
Multiple Job Templates ko ek sequence mein connect karta hai.

---

## 11. Quick Revision

```text
Ansible Core = CLI Automation

Ansible Tower = Centralized Ansible Management

Tower provide karta hai:
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

### Sab se Important Flow

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

**Ansible Tower teams ko Ansible automation ko centrally control, schedule, secure, execute aur multiple systems par monitor karne mein help karta hai.**
