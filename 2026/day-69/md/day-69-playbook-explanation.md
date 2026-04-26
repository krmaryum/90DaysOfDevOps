# Day 69 - Task 1 Playbook Explanation

## Playbook with Inline Comments

```yaml
---  # Marks the beginning of the YAML document

- name: Install and start Nginx on Ubuntu web server        # Name of the play
  hosts: ubuntu_web                                         # Target inventory group
  become: true                                              # Run tasks with sudo privileges

  tasks:                                                    # List of tasks
    - name: Install Nginx                                   # Task description
      apt:                                                  # Module for Ubuntu package management
        name: nginx                                         # Package name
        state: present                                      # Ensure nginx is installed
        update_cache: true                                  # sudo apt update 

    - name: Start and enable Nginx                          # Task description
      service:                                              # Module to manage services
        name: nginx                                         # Service name
        state: started                                      # Ensure service is running
        enabled: true                                       # Enable service on boot

    content: |                                          # Multi-line string (no quotes needed)
      <h1>Deployed by Ansible - TerraWeek Server</h1>   # Clean HTML content
    dest: /var/www/html/index.nginx-debian.html         # Destination path

---

## Step-by-Step Explanation

### 1. YAML Start
`---` marks the start of the YAML file.
This marks the start of the YAML document.

Why it matters:

It tells YAML parsers where the document begins.
It is good practice to include it at the top of Ansible playbooks.

---

### 2. Play Definition
Defines a play that will run on a group of hosts.

```YAML
- name: Install and start Nginx on Ubuntu web server
```
This starts a play.

What a play means:

A play is a set of tasks applied to a group of hosts.
name is just a readable label, so when the playbook runs you can easily understand what it is doing.

You saw this in output:
```text
PLAY [Install and start Nginx on Ubuntu web server]
```
- `name` → Description of the play
- `hosts` → Target group from inventory
- `become` → Enables sudo privileges

---

3. Target hosts
```YAML
  hosts: ubuntu_web
```

This tells Ansible which machines to run the play on.

In your case:

- ubuntu_web is the inventory group
- that group contains your Ubuntu server

So Ansible reads inventory.ini, finds ubuntu_web, and applies all tasks in this play to those hosts.

Think of it like:

- inventory = address book
- hosts: = who should receive this set of instructions

---

4. Privilege escalation
```YAML
  become: true
```

This tells Ansible to run tasks with elevated privileges, usually like sudo.

Why needed here:

- installing packages needs root access
- starting/enabling services needs root access
- writing to /var/www/html/ also needs elevated permissions

Without become: true, these tasks would often fail with permission errors.

### 5. Tasks section
```YAML
  tasks:
```

This begins the list of tasks.

What tasks means:

- each task is one action
- Ansible runs them top to bottom
- order matters

In this playbook, the order is:

1. install Nginx
2. start and enable Nginx
3. create custom web page

That order makes sense because:

- you cannot manage the nginx service before installing nginx
- you want the web page written after the server is installed

---

### 5. Task 1 block: Install Nginx
```YAML
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: true
```

`- name: Install Nginx`
This is the label for the task.

You saw it in output:
```text
TASK [Install Nginx]
```
It helps identify what Ansible is currently doing.

---

### 5. Task 2: Start and Enable Service
Uses the `service` module.

- Starts nginx if not running
- Enables nginx on system boot

---

### 6. Task 3: Create Custom Web Page
Uses the `copy` module.

- Writes HTML content directly into a file
- Replaces default Nginx page

---

## Key Concepts

### Idempotency
Running the playbook multiple times results in the same system state.

- First run → changes applied
- Second run → all tasks show `ok`

---

## Summary

This playbook:

1. Installs Nginx
2. Starts and enables the service
3. Deploys a custom HTML page

It demonstrates core Ansible concepts:
- Playbooks
- Tasks
- Modules
- Idempotency
