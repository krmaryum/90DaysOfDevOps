# Ansible Nginx Reverse Proxy Template Task Explained

## Full Task

```yaml
- name: Deploy reverse proxy configuration
  template:
    src: app-proxy.conf.j2
    dest: /etc/nginx/conf.d/{{ project_name }}.conf
    owner: root
    group: root
    mode: '0644'
  notify: Reload Nginx
  tags: nginx
```

---

# 1. Task Name

```yaml
- name: Deploy reverse proxy configuration
```

This is the human-readable name of the Ansible task.

When the playbook runs, Ansible shows this name in the terminal output.

Example output:

```text
TASK [nginx : Deploy reverse proxy configuration]
```

---

# 2. Template Module

```yaml
template:
```

The `template` module copies a Jinja2 template from the Ansible control node to the managed server.

Before copying, Ansible processes variables inside the template.

Example template line:

```nginx
proxy_pass http://localhost:{{ docker_app_port }};
```

If the variable is:

```yaml
docker_app_port: 8080
```

Ansible renders it as:

```nginx
proxy_pass http://localhost:8080;
```

---

# 3. Source Template File

```yaml
src: app-proxy.conf.j2
```

This tells Ansible which template file to use.

Because this task is inside the `nginx` role, Ansible looks here:

```text
roles/nginx/templates/app-proxy.conf.j2
```

The `.j2` extension means it is a Jinja2 template.

---

# 4. Destination Path

```yaml
dest: /etc/nginx/conf.d/{{ project_name }}.conf
```

This tells Ansible where to copy the rendered file on the managed server.

If your variable is:

```yaml
project_name: devops-app
```

then the final destination becomes:

```text
/etc/nginx/conf.d/devops-app.conf
```

---

# 5. Why `/etc/nginx/conf.d/`?

On RedHat, Rocky Linux, AlmaLinux, and Amazon Linux, Nginx commonly loads extra config files from:

```text
/etc/nginx/conf.d/
```

The main config usually has:

```nginx
include /etc/nginx/conf.d/*.conf;
```

So this file becomes active after Nginx reloads:

```text
/etc/nginx/conf.d/devops-app.conf
```

---

# 6. Owner

```yaml
owner: root
```

This sets the file owner to `root`.

Equivalent command:

```bash
sudo chown root /etc/nginx/conf.d/devops-app.conf
```

---

# 7. Group

```yaml
group: root
```

This sets the file group to `root`.

Equivalent command:

```bash
sudo chgrp root /etc/nginx/conf.d/devops-app.conf
```

---

# 8. Mode

```yaml
mode: '0644'
```

This sets file permissions.

| Who | Permission |
|---|---|
| Owner | Read + Write |
| Group | Read |
| Others | Read |

Equivalent command:

```bash
sudo chmod 644 /etc/nginx/conf.d/devops-app.conf
```

---

# 9. Notify Handler

```yaml
notify: Reload Nginx
```

If this template changes, Ansible triggers the `Reload Nginx` handler.

Example handler:

```yaml
- name: Reload Nginx
  service:
    name: nginx
    state: reloaded
```

Equivalent command:

```bash
sudo systemctl reload nginx
```

---

# 10. Why Reload Nginx?

Reload applies configuration changes without fully stopping Nginx.

Reload is preferred because it:
- applies new config
- avoids downtime
- keeps existing connections alive

---

# 11. Tags

```yaml
tags: nginx
```

This marks the task with the `nginx` tag.

Run only Nginx tasks:

```bash
ansible-playbook site.yml --tags nginx
```

---

# 12. What Happens Internally?

## Step 1

Ansible reads:

```text
roles/nginx/templates/app-proxy.conf.j2
```

## Step 2

Ansible replaces variables like:

```jinja2
{{ project_name }}
{{ docker_app_port }}
```

with real values.

## Step 3

Ansible generates the final Nginx config file.

## Step 4

Ansible copies it to:

```text
/etc/nginx/conf.d/devops-app.conf
```

## Step 5

If the file changed, Ansible triggers:

```yaml
notify: Reload Nginx
```

## Step 6

Nginx reloads and starts using the new reverse proxy config.

---

# 13. Reverse Proxy Meaning

A reverse proxy sits in front of your application.

Flow:

```text
Browser → Nginx → Docker Container
```

Example:

```text
User visits: http://server-ip
Nginx receives traffic on port 80
Nginx forwards traffic to Docker app on localhost:8080
Docker container sends response back
```

---

# 14. Example `app-proxy.conf.j2`

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:{{ docker_app_port }};
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

If:

```yaml
docker_app_port: 8080
```

final output becomes:

```nginx
server {
    listen 80;
    server_name _;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

---

# 15. Summary

This task:

- uses a Jinja2 template
- creates an Nginx reverse proxy config
- places it in `/etc/nginx/conf.d/`
- names the config using `project_name`
- sets ownership and permissions
- reloads Nginx only when needed
- uses the `nginx` tag for selective execution
