# Ansible Playbook Explanation (Block by Block)

## Playbook

``` yaml
- name: Configure web servers
  hosts: ubuntu_web
  become: true
  roles:
    - role: webserver
      vars:
        app_name: terraweek
        http_port: 80

- name: Configure app servers with Docker
  hosts: redhat_app
  become: true
  roles:
    - geerlingguy.docker

- name: Configure database servers
  hosts: amz_db
  become: true
  gather_facts: true

  tasks:
    - name: Create DB config with secrets
      template:
        src: db-config.j2
        dest: /etc/db-config.env
        owner: root
        group: root
        mode: '0600'
```

------------------------------------------------------------------------

## Block 1: Web Servers

-   Targets: `ubuntu_web`
-   Runs with sudo (`become: true`)
-   Applies `webserver` role
-   Passes variables:
    -   `app_name = terraweek`
    -   `http_port = 80`

Purpose: Configure web servers (likely installs Nginx/Apache and deploys
app).

------------------------------------------------------------------------

## Block 2: App Servers (Docker)

-   Targets: `redhat_app`
-   Runs with sudo
-   Uses role: `geerlingguy.docker`

Purpose: Installs and configures Docker on Red Hat-based systems.

------------------------------------------------------------------------

## Block 3: Database Servers

-   Targets: `amz_db`
-   Runs with sudo
-   `gather_facts: true` enables system info collection

Purpose: Prepare DB servers and use facts (like IP address) in
templates.

------------------------------------------------------------------------

## Task: Create DB Config File

Uses the Ansible `template` module:

-   Source: `db-config.j2`
-   Destination: `/etc/db-config.env`
-   Owner: root
-   Permissions: `0600` (secure, only root can read/write)

Purpose: Generate a secure environment file containing DB credentials
and settings.

------------------------------------------------------------------------

## Key Notes

-   Facts are required for dynamic values like IP address
-   Secrets should come from Ansible Vault
-   File permissions protect sensitive data

------------------------------------------------------------------------

Generated on: 2026-05-05 03:34:32
