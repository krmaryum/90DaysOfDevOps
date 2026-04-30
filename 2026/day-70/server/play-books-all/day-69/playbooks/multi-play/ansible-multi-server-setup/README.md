# Ansible Multi-Server Setup

This project demonstrates how to use Ansible to configure different server groups based on their roles and operating systems.

## Project Structure

```text
ansible-multi-server-setup/
├── inventory.ini
├── multi_server_setup.yml
└── README.md
```

## Server Groups

| Group | Purpose | OS Type |
|---|---|---|
| `ubuntu_web` | Web server | Ubuntu/Debian |
| `redhat_app` | Application server | RedHat/CentOS |
| `amz_db` | Database utility server | Amazon Linux |

## What the Playbook Does

### Ubuntu Web Servers

- Installs Nginx
- Starts Nginx
- Enables Nginx on boot

### RedHat App Servers

- Installs build dependencies:
  - `gcc`
  - `make`
- Creates `/opt/app`

### Amazon Linux DB Servers

- Installs MariaDB client
- Creates `/var/lib/appdata` with secure permissions

## How to Use

Update `inventory.ini` with your real server IP addresses:

```ini
[ubuntu_web]
ubuntu-web-1 ansible_host=YOUR_UBUNTU_IP ansible_user=ubuntu
```

Then test connectivity:

```bash
ansible -i inventory.ini all -m ping
```

Run the playbook:

```bash
ansible-playbook -i inventory.ini multi_server_setup.yml
```

## Key Concepts Practiced

- Multi-play Ansible playbooks
- Inventory groups
- OS-specific package modules
- Service management
- Directory creation and permissions
- Idempotency

## Notes

- `apt` is used for Ubuntu/Debian systems.
- `yum` is used for RedHat/Amazon Linux systems.
- `become: true` is required because package installation and system directory creation need sudo/root privileges.

## Summary

This project is a simple real-world DevOps automation example where different server types are configured from one Ansible playbook.
