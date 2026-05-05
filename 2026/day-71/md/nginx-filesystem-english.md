## Nginx File System Explained (For Ansible Webserver Role)

### Overview

This document explains how the Nginx file system is structured and how each part is used in your Ansible webserver role.

---

### Nginx Core Structure

Nginx typically uses three main components:

1. Main Configuration File  
2. Virtual Host Configuration  
3. Web Content (HTML files)

---

### 1. Main Configuration File

**Path:**
/etc/nginx/nginx.conf

**Purpose:**

This is the main configuration file for Nginx. It controls global settings such as:

- Worker processes
- Maximum connections
- Performance tuning
- Includes other configuration files

**In your role:**

nginx.conf.j2 → /etc/nginx/nginx.conf

This file is rendered using a Jinja2 template to dynamically configure values like `max_connections`.

---

### 2. Virtual Host Configuration

**Path:**
/etc/nginx/conf.d/

**Purpose:**

Each file in this directory represents a website or application.

Example:
terraweek.conf

This file defines:

- Port (e.g., listen 80)
- Root directory (/var/www/app)
- Request handling rules

**In your role:**

/etc/nginx/conf.d/{{ app_name }}.conf

This is generated using a template (vhost.conf.j2).

---

### 3. Web Content (Web Root)

**Path:**
/var/www/{{ app_name }}/

**Purpose:**

This directory contains the actual website files:

- index.html
- CSS / JS files

**In your role:**

/var/www/{{ app_name }}/index.html

This file is created using a template (index.html.j2).

---

### How Everything Works Together

Step-by-step flow:

1. User opens browser and accesses server IP  
2. Nginx reads /etc/nginx/nginx.conf  
3. nginx.conf includes all files from /etc/nginx/conf.d/  
4. Specific vhost config (e.g., terraweek.conf) is applied  
5. Nginx reads the root path (/var/www/app)  
6. index.html is served to the browser  

---

### Visual Flow

nginx.conf  
   ↓  
conf.d/terraweek.conf  
   ↓  
/var/www/terraweek/index.html  

---

### Key Concepts

- nginx.conf = global settings  
- conf.d = site configurations  
- /var/www = application files  

---

### Conclusion

Nginx works by combining:

Configuration + Site Rules + Content Files

Your Ansible role automates all of these components, allowing you to deploy and manage web servers consistently across multiple machines.
