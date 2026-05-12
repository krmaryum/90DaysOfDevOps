# DevOps Project Debugging Summary

You successfully built and debugged:

- Ansible inventory
- Common role
- Docker role
- Nginx role
- Reverse proxy setup
- Cross-platform support (Ubuntu + RedHat)
- Docker container deployment
- Nginx templating
- Handlers
- Health checks

Here’s the complete issue → solution summary.

---

# 1. Wrong Command Typo

## Issue

```bash
ansible web -m command -a "datetimectl"
```

Error:

```text
No such file or directory
```

## Cause

Command typo.

Correct command:

```bash
timedatectl
```

## Solution

```bash
ansible web -m command -a "timedatectl"
```

---

# 2. Using `apt` for RedHat

## Issue

You wrote:

```yaml
- name: Update package For RedHat
  apt:
```

## Cause

`apt` works only on Debian/Ubuntu.

## Solution

Use:

```yaml
yum:
```

or:

```yaml
dnf:
```

for RedHat systems.

---

# 3. `package` Module Confusion

## Issue

Tried:

```yaml
package:
  update_cache: true
```

## Cause

`package` module is generic and does NOT support:
- `update_cache`
- `makecache`

because those are package-manager-specific options.

## Solution

Use:
- `apt` for Debian cache update
- `yum`/`dnf` for RedHat cache update

Then use:

```yaml
package:
```

for generic package installation.

---

# 4. Wrong Jinja Syntax

## Issue

```yaml
name: "{{ docker_package[ansible_facts['os_family]] }}"
```

## Cause

Missing closing quote.

## Solution

Correct syntax:

```yaml
name: "{{ docker_package[ansible_facts['os_family']] }}"
```

---

# 5. Docker Login Permission Error

## Issue

```text
chmod: invalid mode: ‘A+user:deploy:rx:allow’
```

## Cause

Problem caused by:

```yaml
become_user: deploy
```

with Ansible temporary permissions.

## Solution

Removed:

```yaml
become_user: deploy
```

from Docker login task.

---

# 6. Docker Compose Package Not Found

## Issue

```text
No package matching 'docker-compose-plugin' is available
```

## Cause

Ubuntu repository did not contain package.

## Solution

Installed:

```yaml
docker-compose
```

instead.

---

# 7. SSH Transfer Error

## Issue

```text
sftp transfer mechanism failed
scp transfer mechanism failed
```

## Cause

Ansible SSH transfer/pipelining issue.

## Solution

Added to `ansible.cfg`:

```ini
[ssh_connection]
pipelining = True
scp_if_ssh = True
```

---

# 8. `nginx -t` Failed

## Issue

```text
No such file or directory: b'nginx'
```

## Cause

Nginx was not installed.

## Solution

Installed Nginx:

```bash
ansible web -m apt -a "name=nginx state=present update_cache=true" --become
```

---

# 9. Nginx Role Not Running

## Issue

```text
ok=1 changed=0
```

when running:

```bash
ansible-playbook site.yml --tags nginx
```

## Cause

Tasks were missing:

```yaml
tags: nginx
```

## Solution

Added `tags: nginx` to all Nginx tasks.

---

# 10. Broken `nginx.conf.j2`

## Issue

```text
unexpected "}"
```

## Cause

Extra closing brace and duplicate include block.

## Solution

Removed duplicate conditional block.

---

# 11. Nginx Running But Connection Refused

## Issue

```text
Connection refused
```

even though Nginx service was active.

## Cause

No active server block loaded.

Your:

```text
/etc/nginx/conf.d/devops-app.conf
```

was empty.

So:
- Nginx started
- but nothing listened on port 80

## Solution

Fixed:

```text
roles/nginx/templates/app-proxy.conf.j2
```

Added:

```nginx
server {
    listen 80;

    location / {
        proxy_pass http://localhost:8080;
    }
}
```

---

# 12. `ss | grep nginx` Failed

## Issue

```bash
ansible web -m command -a "ss -tulnp | grep nginx"
```

failed.

## Cause

`command` module does NOT support shell pipes (`|`).

## Solution

Used:

```bash
ansible web -m shell -a "ss -tulnp | grep :80" --become
```

because `shell` supports pipes.

---

# 13. `/health` Returned 404

## Issue

```text
404 Not Found
```

## Cause

No `/health` endpoint configured.

## Solution Options

Either:
- test `/`
- or add:

```nginx
location /health {
    return 200 'OK';
}
```

---

# 14. Cross-Platform Nginx Includes

## Issue

Ubuntu uses:

```text
sites-enabled
```

RedHat uses:

```text
conf.d
```

## Solution

Used Jinja2 conditional logic:

```nginx
{% if ansible_facts['os_family'] == "Debian" %}
include /etc/nginx/sites-enabled/*;
{% elif ansible_facts['os_family'] == "RedHat" %}
include /etc/nginx/conf.d/*.conf;
{% endif %}
```

---

# 15. Final Successful State

## Nginx

```text
0.0.0.0:80
```

listening successfully.

---

## Docker

```text
0.0.0.0:8080
```

container running successfully.

---

## Health Check

```text
status: 200
```

successful.

---

# Final Architecture

```text
Browser
   ↓
Nginx (port 80)
   ↓
Reverse Proxy
   ↓
Docker Container (port 8080)
   ↓
Nginx App
```

---

# Major Concepts You Learned

- Ansible roles
- Tags
- Handlers
- Jinja2 templates
- Conditional logic
- Cross-platform automation
- Docker automation
- Reverse proxying
- Nginx architecture
- Service validation
- Health checks
- SSH troubleshooting
- Idempotency
- Production debugging workflow

This was a very realistic DevOps troubleshooting session.
