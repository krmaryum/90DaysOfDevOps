# Day 69 - Ansible Playbooks and Modules

## Table of Contents

| Task       | Title                        | Summary                                                                                                                       | Link                                                                        |
| ---------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| **Task 1** | First Playbook (Nginx Setup) | Created first Ansible playbook to install Nginx, start service, and deploy a custom web page. Introduced idempotency.         | [Go to Task 1](#task-1-your-first-playbook)                                 |
| **Task 2** | Playbook Structure           | Learned play vs task, modules, `become`, execution flow, and failure behavior.                                                | [Go to Task 2](#task-2-understand-the-playbook-structure)                   |
| **Task 3** | Essential Modules            | Practiced core modules (`apt`, `yum`, `service`, `copy`, `file`, `command`, `shell`, `lineinfile`). Learned command vs shell. | [Go to Task 3](#task-3-essential-modules)                                   |
| **Task 4** | Handlers                     | Implemented handlers to restart services only when configuration changes occur.                                               | [Go to Task 4](#day-69---task-4-handlers-restart-services-only-when-needed) |
| **Task 5** | Dry Run, Diff & Verbosity    | Used `--check`, `--diff`, and verbosity flags for safe execution and debugging.                                               | [Go to Task 5](#day-69---task-5-dry-run-diff-and-verbosity)                 |
| **Task 6** | Multiple Plays               | Built multi-play playbook to manage web, app, and database servers separately.                                                | [Go to Task 6](#task-6-multiple-plays-in-one-playbook)                      |



## Day 69 Overview

In Day 69, the focus moves from ad-hoc commands to Ansible playbooks.

Ad-hoc commands are useful for quick one-time operations, but playbooks are used for real automation. A playbook is a YAML file that describes the desired state of a server, such as installed packages, running services, and deployed files.

In this task, the goal is to create the first playbook to install Nginx, start the service, and deploy a custom web page on the Ubuntu web server.

---

## Day 69 Objective

The objective of this task is to:

- Understand the basic structure of an Ansible playbook
- Target the correct inventory group
- Install Nginx using Ansible
- Start and enable the Nginx service
- Create a custom index page
- Observe `changed` and `ok` in playbook output
- Understand idempotency by running the same playbook twice

---

## Task 1: Your First Playbook

### Create `install-nginx.yml`

```yaml
---
- name: Install and start Nginx on Ubuntu web server
  hosts: ubuntu_web
  become: true

  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Start and enable Nginx
      service:
        name: nginx
        state: started
        enabled: true

    - name: Create a custom index page
      copy:
        content: "<h1>Deployed by Ansible - TerraWeek Server</h1>"
        dest: /var/www/html/index.nginx-debian.html
```

[install-nginx.yml](md/day-69-playbook-explanation.md)

---

## Run the playbook

```bash
ansible-playbook install-nginx.yml
```

---

## Expected Output

First run:
- Tasks show `changed`

Second run:
- Tasks show `ok`

This demonstrates idempotency.

---

## Verification

```bash
curl http://<your-server-ip>
```

Expected output:

```html
<h1>Deployed by Ansible - TerraWeek Server</h1>
```

---

## Summary

This task demonstrates how to create a simple Ansible playbook to automate:

- Package installation
- Service management
- File deployment

It also introduces idempotency, a core concept in Ansible automation.

---

## Task 2: Understand the Playbook Structure

### Task Overview

In this task, I analyzed the structure of an Ansible playbook to understand how automation is organized. A playbook is composed of plays, tasks, and modules, each serving a specific purpose.

By breaking down the playbook, I learned how Ansible targets hosts, executes tasks sequentially, and uses modules to perform operations like installing packages and managing services.

### Task Objective

The objective of this task is to:

- Understand the structure of a playbook (plays, tasks, modules)
- Learn the difference between a play and a task
- Understand how Ansible targets hosts using hosts
- Learn how privilege escalation works using become
- Understand execution flow when tasks succeed or fail
- Learn that multiple plays can exist in a single playbook

## Annotated Structure

```yaml
---                                    # YAML document start

- name: Play name                      # PLAY -- defines a set of tasks for a group of hosts
  hosts: web                           # Target inventory group
  become: true                         # Run tasks with sudo privileges

  tasks:                               # List of tasks
    - name: Task name                  # TASK -- a single unit of work
      module_name:                     # MODULE -- action performed by Ansible
        key: value                     # Arguments passed to the module
```

---

## Answers

### 1. What is the difference between a play and a task?

- A **play**:
  - Targets a group of hosts
  - Contains multiple tasks
  - Defines *where* and *how* to run automation

- A **task**:
  - A single action performed on a host
  - Uses a module to do one specific job
  - Example: install a package, start a service

In simple terms:
- **Play = group of instructions**
- **Task = one instruction**

---

### 2. Can you have multiple plays in one playbook?

Yes, you can have multiple plays in a single playbook.

Example:
```yaml
- name: Configure web servers
  hosts: ubuntu_web
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present

- name: Configure database servers
  hosts: amz_db
  tasks:
    - name: Install MySQL
      yum:
        name: mysql-server
        state: present
```

Each play can:
- Target different host groups
- Have different tasks

---

### 3. What does `become: true` do at play level vs task level?

**At play level:**
```yaml
become: true
```
- Applies to all tasks in that play
- All tasks run with sudo privileges

**At task level:**
```yaml
- name: Install package
  apt:
    name: nginx
  become: true
```
- Only that specific task runs with sudo
- Other tasks run without privilege escalation

Summary:
- Play level → affects all tasks
- Task level → affects only one task

---

### 4. What happens if a task fails -- do remaining tasks still run?

By default: **NO**

- If a task fails:
  - Ansible stops execution for that host
  - Remaining tasks are not executed for that host

Example:
- Task 1 → success
- Task 2 → fails 
- Task 3 → skipped

---

### Exception

You can override this behavior using:

```yaml
ignore_errors: true
```

Then Ansible will:
- Continue execution even if a task fails

---

## Summary

- Play = targets hosts and groups tasks
- Task = single action using a module
- Multiple plays are allowed in one playbook
- `become: true` controls privilege escalation
- By default, failure stops execution on that host

---

## Task 3: Essential Modules

## Task Overview

In this task, I practiced commonly used Ansible modules by creating a playbook (`essential-modules.yml`) and executing it across multiple servers (Ubuntu, Red Hat, and Amazon Linux). The playbook demonstrates real-world automation tasks such as package installation, service management, file operations, command execution, and configuration updates.

---

## Task Objective

- Learn and practice core Ansible modules
- Work with multiple operating systems using conditional logic
- Install packages using apt and yum
- Manage services using the service module
- Copy files from control node to managed nodes
- Create directories with permissions
- Execute commands and capture output
- Display results using debug
- Modify configuration files using lineinfile
- Understand the difference between command and shell

---

## Playbook

```yaml
---
- name: Practice essential Ansible modules on all servers
  hosts: all_servers
  become: true

  tasks:
    - name: Install multiple packages on ubuntu
      apt:
        name:
          - git
          - curl
          - wget
          #- tree
        state: present
        update_cache: true  # sudo apt update
      when: ansible_facts['os_family'] == "Debian"

    - name: Install multiple packages on RedHat / Amazon Linux
      yum:
        name:
          - git
          #- curl
          - wget
          - tree
        state: present
        # update_cache: true # update_cache is not valid for yum
      when: ansible_facts['os_family'] == "RedHat"


    - name: Install Nginx on Ubuntu
      apt:
        name: nginx
        state: present
        update_cache: true
      when: "'ubuntu_web' in group_names"

    - name: Ensure Nginx is Running
      service:
        name: nginx
        state: started
        enabled: true
      when: "'ubuntu_web' in group_names"

    - name: Copy Text file
      copy:
          src: apps/pub-ips.txt
          dest: /tmp/pub-ips.txt
          owner: root
          group: root
          mode: '0644'

    - name: Create Application directory
      file:
        path: /opt/myapp
        state: directory
        owner: "{{ ansible_user }}"
        mode: '0755'

    - name: Check disk Space
      command: df -h
      register: disk_output  # register = save output to variable , disk_output.stdout = actual result

    - name: Print disk Space
      debug:                 # Used to print variables/output OR Prints output
        var: disk_output.stdout_lines   # stdout → one paragraph , stdout_lines → bullet points

    - name: Count Running processes
      shell: ps aux | wc -l
      register: process_count

    - name: Show process Count
      debug:
        msg: "Total processes: {{ process_count.stdout }}"  # Jinja2 variable syntax

    - name: Set timezone in environment
      lineinfile:           # add/update a line and ensure a line exists in a file
        path: /etc/environment
        line: 'TZ=America/Chicago'
        create: true
```

---

### Module Explanations
#### apt / yum

Used for package management.

- `apt` is used for Ubuntu/Debian systems
- `yum` is used for Red Hat and Amazon Linux
- `state: present` ensures packages are installed

---

### service

Used to manage system services.

- state: started ensures the service is running
- enabled: true ensures it starts on boot

---

### copy

Copies files from the control node to managed nodes.

- `src` → local file path
- `dest` → destination path on remote server

---

### When to Use

- Use **command** for simple and secure execution
- Use **shell** only when shell features are required

---

### debug

Used to print variables and outputs.

- Helps in debugging and verification

---

### lineinfile

Ensures a specific line exists in a file.

- Can create the file if it does not exist
- Prevents duplicate entries

---

## Difference Between command and shell
#### command module
- Executes commands directly without using a shell
- Does NOT support:
   - pipes (|)
   - redirects (>)
   - wildcards (*)
   - environment variables ($HOME)
   - More secure and predictable

Example:
```YAML
command: df -h
```

---

#### shell module
- Executes commands through a shell (/bin/bash)
- Supports:
   - pipes (|)
   - redirects (>)
   - chaining commands
   - environment variables

Example:
```YAML
shell: ps aux | wc -l
```

#### When to use each
- Use command by default (safer)
- Use shell only when shell features are required

### Important difference
#### Bad practice
```YAML
- name: Create directory (wrong)
  shell: mkdir /opt/myapp
```
#### Problems:

- Not idempotent
- Can fail if exists
- Not clean

#### Correct (what you did)
```YAML
- name: Create directory
  file:
    path: /opt/myapp
    state: directory
```
Best practice

---

## Summary

In this task, I created a playbook using essential Ansible modules and executed it across multiple servers. I learned how to handle different operating systems, manage services, transfer files, and run commands. I also understood the difference between `command` and `shell`, which is critical for writing safe and efficient automation scripts.

---

# Day 69 - Task 4: Handlers (Restart Services Only When Needed)

## Overview

In this task, I learned how Ansible handlers work. Handlers are special tasks that run **only when triggered** by another task using `notify`. This ensures services are restarted **only when necessary**, avoiding unnecessary downtime.

---

## Objective

- Configure Nginx using Ansible
- Deploy configuration files
- Use `notify` to trigger a handler
- Restart Nginx only when configuration changes
- Verify handler behavior (first run vs second run)

---

## Playbook: nginx-config.yml

```yaml
---
- name: Configure Nginx with a custom config
  hosts: all_servers
  become: true

  tasks:
    - name: Install Nginx on Ubuntu
      apt:
        name: nginx
        state: present
        update_cache: true
      when: ansible_facts['os_family'] == 'Debian'

    - name: Install Nginx on RedHat / Amazon Linux
      yum:
        name: nginx
        state: present
      when: ansible_facts['os_family'] == "RedHat"

    - name: Deploy Nginx config
      copy:
        src: files/nginx.conf
        dest: /etc/nginx/nginx.conf
        owner: root
        group: root
        mode: '0644'
      notify: Restart Nginx

    - name: Set nginx user for Ubuntu
      lineinfile:
        path: /etc/nginx/nginx.conf
        regexp: '^user'
        line: 'user www-data;'
        create: true
      notify: Restart Nginx
      when: ansible_facts['os_family'] == 'Debian'

    - name: Set nginx user for RedHat / Amazon Linux
      lineinfile:
        path: /etc/nginx/nginx.conf
        regexp: '^user'
        line: 'user nginx;'
        create: true
      notify: Restart Nginx
      when: ansible_facts['os_family'] == "RedHat"

    - name: Deploy custom index page
      copy:
        content: |
          <h1>Managed by Ansible</h1>
          <p>Server: {{ inventory_hostname }}</p>
        dest: /usr/share/nginx/html/index.html

    - name: Ensure Nginx is running
      service:
        name: nginx
        state: started
        enabled: true

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

---

## How Handlers Work

- The `copy` and `lineinfile` tasks use `notify: Restart Nginx`
- If these tasks report `changed`, the handler is triggered
- The handler runs **only once at the end of the play**, even if notified multiple times

---

## Execution Results

### First Run

- Config file is newly deployed → `changed`
- Handler is triggered
- Nginx is restarted

Example:

```
TASK [Deploy Nginx config] changed
RUNNING HANDLER [Restart Nginx] changed
```

---

### Second Run (Idempotency Check)

- No changes in config → tasks show `ok`
- Handler is NOT triggered

Example:

```
TASK [Deploy Nginx config] ok
(no handler execution)
```

---

## Verification

### Check Nginx locally on each server

```bash
ansible all -m shell -a "curl -s localhost"
```

### Output

```
<h1>Managed by Ansible</h1>
<p>Server: worker-amazon</p>

<h1>Managed by Ansible</h1>
<p>Server: worker-ubuntu</p>

<h1>Managed by Ansible</h1>
<p>Server: worker-redhat</p>
```

---

## Key Concepts Learned

- Handlers run only when notified
- Prevent unnecessary service restarts
- Improve efficiency and reliability
- Run once at the end of execution
- Work with modules like `copy`, `template`, `lineinfile`

---

## Difference Between Tasks and Handlers

| Tasks | Handlers |
|------|--------|
| Always run | Run only when notified |
| Execute immediately | Execute at end of play |
| Used for actions | Used for conditional actions |

---

## Conclusion

Handlers are essential for efficient automation. They ensure services are restarted only when configuration changes, making playbooks more reliable and production-ready.

---

# Day 69 - Task 5: Dry Run, Diff, and Verbosity

## Overview

Before applying changes to production systems, it is critical to preview what will happen. Ansible provides powerful options like `--check`, `--diff`, and verbosity flags to safely validate playbooks.

---

## Objective

- Understand dry run mode (`--check`)
- Understand diff mode (`--diff`)
- Use verbosity flags for debugging
- Safely preview changes before execution
- Learn why these flags are essential in production

---

## Dry Run (Check Mode)

Dry run allows you to simulate execution without making any changes.

```bash
ansible-playbook install-nginx.yml --check
```

### What it does:
- Shows what tasks *would* change
- Does NOT apply changes
- Helps validate logic safely

---

## Diff Mode

Diff mode shows the actual differences in files.

```bash
ansible-playbook nginx-config.yml --check --diff
```

### What it does:
- Displays before vs after content of files
- Useful for config changes
- Works best with `--check`

---

## Verbosity Levels

Increase output detail for debugging.

```bash
ansible-playbook install-nginx.yml -v
ansible-playbook install-nginx.yml -vv
ansible-playbook install-nginx.yml -vvv
```

### Levels:

| Flag | Description |
|------|------------|
| -v   | Basic details |
| -vv  | More detailed output |
| -vvv | Debug-level (SSH, connection info) |

---

## Limit Execution to Specific Hosts

```bash
ansible-playbook install-nginx.yml --limit web-server
```

### Use case:
- Test on one server before full rollout

---

## List Hosts and Tasks

```bash
ansible-playbook install-nginx.yml --list-hosts
ansible-playbook install-nginx.yml --list-tasks
```

### What it does:
- Shows which hosts will be targeted
- Shows tasks without executing them

---

## Why `--check --diff` is Critical in Production

Using `--check --diff` together is the safest way to validate changes before applying them.

### Key reasons:

1. **Prevents unexpected changes**
   - You see exactly what will change before execution

2. **Avoids downtime**
   - No actual changes are made during validation

3. **Validates configuration updates**
   - Especially useful for config files like Nginx

4. **Provides transparency**
   - Shows precise file differences (before vs after)

5. **Ensures idempotency**
   - Helps confirm playbook behaves correctly

6. **Safer deployments**
   - Reduces risk in production environments

---

## Example Workflow (Best Practice)

```bash
# Step 1: Preview changes
ansible-playbook nginx-config.yml --check --diff

# Step 2: Apply changes if everything looks correct
ansible-playbook nginx-config.yml
```

---

## Conclusion

- Always use `--check --diff` before production runs
- Use verbosity flags for debugging issues
- Validate changes safely to avoid breaking systems

---

## Final Takeaway

> Never run a playbook blindly in production. Always preview changes first.

---

# Task 6: Multiple Plays in One Playbook

## Overview

In this task, I created a single Ansible playbook containing multiple plays. Each play targets a different server group and executes only the relevant tasks.

This approach allows managing multiple server roles (web, app, database) within one playbook.

---

## Objective

- Create a playbook with multiple plays
- Target different inventory groups
- Apply role-specific configurations
- Verify tasks run only on intended hosts
- Demonstrate idempotency

---

## Playbook: multi-play.yml

```yaml
---
- name: Configure web servers
  hosts: ubuntu_web
  become: true

  tasks:
    - name: Install Nginx on Ubuntu web server
      apt:
        name: nginx
        state: present
        update_cache: true

    - name: Start Nginx
      service:
        name: nginx
        state: started
        enabled: true


- name: Configure app servers
  hosts: redhat_app
  become: true

  tasks:
    - name: Install application build dependencies
      yum:
        name:
          - gcc
          - make
        state: present

    - name: Create app directory
      file:
        path: /opt/app
        state: directory
        mode: '0755'


- name: Configure database servers
  hosts: amz_db
  become: true

  tasks:
    - name: Install MariaDB client
      yum:
        name: mariadb105
        state: present

    - name: Create data directory
      file:
        path: /var/lib/appdata
        state: directory
        mode: '0700'
```

---

## Execution

### Run the playbook

```bash
ansible-playbook playbooks/multi-play.yml
```

---

## Output Behavior

- Each play runs separately
- Tasks execute only on targeted hosts
- No cross-execution between server roles

---

## Verification

### 1. Verify Nginx on web server only

```bash
ansible ubuntu_web -m command -a "nginx -v" --become
```

Expected:
- Installed only on web server
- Not present on app/db servers

---

### 2. Verify app directory on app server

```bash
ansible redhat_app -m shell -a "ls -ld /opt/app"
```

Expected:
- Directory exists only on app server

---

### 3. Verify database directory on db server

```bash
ansible amz_db -m shell -a "ls -ld /var/lib/appdata"
```

Expected:
- Directory exists only on database server

### 2. Add a custom Nginx homepage
Add this under the Ubuntu web server tasks:
```YAML
- name: Create custom Nginx homepage
  copy:
    content: "<h1>Deployed by Ansible - Day 69</h1>\n"
    dest: /var/www/html/index.nginx-debian.html
```

then run:
```bash
ansible-playbook playbooks/multi-play.yml
```

### 3. Test in browser

Open:

```
http://<ubuntu-server-ip>
```

Best next milestone: turn this playbook into an Ansible role. That is the real production-style structure.

---

## Idempotency Check

Run playbook again:

```bash
ansible-playbook playbooks/multi-play.yml
```

Expected:

```
changed=0
```

This confirms:
- No unnecessary changes
- Playbook is idempotent

---

## Key Concepts Learned

- Multiple plays in one playbook
- Targeting different host groups
- Role-based configuration
- Separation of concerns
- Idempotent infrastructure automation

---

## Conclusion

Using multiple plays in a single playbook allows clean and efficient management of different server roles. Each play operates independently, ensuring tasks are executed only where needed.

This is a foundational concept for scaling Ansible in real-world environments.

---

## Final Conclusion

In Day 69, I progressed from running ad-hoc commands to building structured, reusable, and idempotent Ansible playbooks. I learned how to manage multiple servers, handle different operating systems, use handlers for efficient service management, and safely preview changes using check and diff modes.

These concepts form the foundation for real-world infrastructure automation and production-grade DevOps practices.