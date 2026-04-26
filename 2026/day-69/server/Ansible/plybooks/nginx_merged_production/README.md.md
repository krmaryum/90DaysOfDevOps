# 📘 Nginx Merged Playbook – Block-by-Block Explanation

## 1. Play Header
Defines where and how the playbook runs.
- hosts: target group
- become: run with sudo
- gather_facts: collect system info

---

## 2. Variables Block
Stores reusable values like:
- package name
- service name
- config path
- web root
- OS-based user selection

---

## 3. Install Nginx
Uses the package module to install Nginx across all OS families.

---

## 4. Create Web Root Directory
Ensures the web directory exists with correct permissions.

---

## 5. Deploy Nginx Configuration
Copies custom nginx.conf to the system and creates backup.

---

## 6. Nginx Config Content
Defines:
- user
- worker processes
- events block
- HTTP server behavior
- file serving rules

---

## 7. Validation Step
Runs:
nginx -t -c <file>
Prevents broken configurations from being applied.

---

## 8. Notify Handler
Triggers restart only if config changes.

---

## 9. Deploy Index Page
Creates a custom HTML page showing:
- server name
- OS family

---

## 10. Start and Enable Service
Ensures Nginx is:
- running
- enabled at boot

---

## 11. Handler Block
Restarts Nginx only when required.

---

## 🧠 Summary
This playbook:
- Installs Nginx
- Configures it dynamically
- Deploys content
- Ensures reliability with validation
- Uses handlers for efficient restarts

Perfect example of a production-ready Ansible workflow 🚀
