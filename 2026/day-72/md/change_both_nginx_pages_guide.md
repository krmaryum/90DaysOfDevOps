# Changing Both Nginx Pages (Host + Docker Container)

Currently your setup works like this:

```text
Browser
   ↓
Host Nginx (Port 80)
   ↓
Reverse Proxy
   ↓
Docker Container (Port 8080)
   ↓
Nginx Container Page
```

Both pages can be customized.

---

# Goal

Replace the default:

```text
Welcome to nginx!
```

with your own custom page.

---

# Step 1: Create Custom HTML Page

Add these tasks inside:

```text
roles/docker/tasks/main.yml
```

Place them BEFORE:

```yaml
- name: Run application container
```

---

# Step 2: Create Application Directory

```yaml
- name: Create application directory
  file:
    path: /opt/app
    state: directory
    mode: '0755'
  tags: docker
```

## Explanation

This creates:

```text
/opt/app
```

on the EC2 host machine.

---

# Step 3: Create Custom HTML Page

```yaml
- name: Create custom index page
  copy:
    dest: /opt/app/index.html
    content: |
      <h1>Hello from DevOps Project</h1>
    mode: '0644'
  tags: docker
```

## Explanation

This creates:

```text
/opt/app/index.html
```

with custom HTML content.

Instead of the default Nginx welcome page, your own page will be served.

---

# Step 4: Mount HTML File into Docker Container

Inside the Docker container task:

```yaml
- name: Run application container
  community.docker.docker_container:
```

add:

```yaml
volumes:
  - /opt/app/index.html:/usr/share/nginx/html/index.html
```

---

# Complete Example

```yaml
- name: Run application container
  community.docker.docker_container:
    name: "{{ docker_app_name }}"
    image: "{{ docker_app_image }}:{{ docker_app_tag }}"
    state: started
    restart_policy: always
    published_ports:
      - "{{ docker_app_port }}:{{ docker_container_port }}"
    volumes:
      - /opt/app/index.html:/usr/share/nginx/html/index.html
  tags: docker
```

---

# What This Means

```yaml
/opt/app/index.html:/usr/share/nginx/html/index.html
```

maps:

| EC2 Host | Docker Container |
|---|---|
| /opt/app/index.html | /usr/share/nginx/html/index.html |

Docker replaces the container’s default Nginx page with your custom HTML file.

---

# Step 5: Run Docker Role Again

```bash
ansible-playbook site.yml --tags docker
```

---

# Step 6: Verify Container

Check container:

```bash
ansible web -m command -a "docker ps" --become
```

---

# Step 7: Verify Custom Page

Open browser:

```text
http://3.16.1.102
```

or:

```text
http://3.16.1.102:8080
```

You should now see:

```text
Hello from DevOps Project
```

instead of:

```text
Welcome to nginx!
```

---

# Why Use YAML Instead of CLI?

You previously used CLI command:

```bash
ansible web -m shell -a 'mkdir -p /opt/app && echo "<h1>Hello from DevOps Project</h1>" > /opt/app/index.html' --become
```

This is okay for:
- quick testing
- debugging
- temporary changes

But production DevOps usually uses YAML tasks because they are:

- repeatable
- version controlled
- automated
- reusable
- idempotent
- team-friendly

---

# CLI vs YAML

## CLI Ad-hoc Commands

Good for:
- quick fixes
- testing
- troubleshooting

Bad for:
- production infrastructure
- repeatable deployments
- CI/CD

---

## YAML Playbooks and Roles

Good for:
- Infrastructure as Code
- Git version control
- automation
- CI/CD pipelines
- team collaboration
- production environments

This is standard industry practice.

---

# Final Architecture

```text
Browser
   ↓
Host Nginx (Port 80)
   ↓
Reverse Proxy
   ↓
Docker Container (Port 8080)
   ↓
Custom HTML Page
```

---

# Result

Both pages are now customized:
- Host Nginx reverse proxy works
- Docker container serves your own custom page

No more default Nginx welcome page.
