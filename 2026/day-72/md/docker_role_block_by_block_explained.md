# Docker Role Explained Block by Block

---

# YAML Document Start

```yaml
---
```

This marks the beginning of a YAML document.

---

# 1. Install Docker Dependencies

```yaml
- name: Install Docker dependencies
  apt:
    name:
      - ca-certificates
      - curl
      - gnupg
      - python3-pip
      - python3-docker
    state: present
    update_cache: true
  tags: docker
```

## Purpose

Installs required packages for Docker and Ansible Docker modules.

## Package Explanation

| Package | Purpose |
|---|---|
| ca-certificates | SSL certificate validation |
| curl | Download files from URLs |
| gnupg | Verify package signatures |
| python3-pip | Python package manager |
| python3-docker | Python Docker SDK used by Ansible |

## Important Setting

```yaml
update_cache: true
```

Equivalent Linux command:

```bash
apt update
```

## Tags

```yaml
tags: docker
```

Allows running only Docker-related tasks:

```bash
ansible-playbook site.yml --tags docker
```

---

# 2. Install Docker

```yaml
- name: Install Docker
  apt:
    name: docker.io
    state: present
  tags: docker
```

## Purpose

Installs Docker Engine from Ubuntu repositories.

Equivalent command:

```bash
sudo apt install docker.io
```

## Idempotency

```yaml
state: present
```

Means:
- install if missing
- do nothing if already installed

---

# 3. Start and Enable Docker Service

```yaml
- name: Start and enable Docker service
  service:
    name: docker
    state: started
    enabled: true
  tags: docker
```

## Purpose

Starts Docker service and enables automatic startup during boot.

Equivalent commands:

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

# 4. Add Deploy User to Docker Group

```yaml
- name: Add deploy user to docker group
  user:
    name: deploy
    groups: docker
    append: true
  notify: Restart Docker
  tags: docker
```

## Purpose

Allows the deploy user to run Docker commands without sudo.

Example:

```bash
docker ps
```

instead of:

```bash
sudo docker ps
```

## append: true

Preserves existing group memberships.

Without it, existing groups could be overwritten.

## notify

```yaml
notify: Restart Docker
```

Triggers a handler if this task changes.

Handler example:

```yaml
- name: Restart Docker
  service:
    name: docker
    state: restarted
```

Equivalent command:

```bash
sudo systemctl restart docker
```

---

# 5. Log in to Docker Hub

```yaml
- name: Log in to Docker Hub
  community.docker.docker_login:
    username: "{{ vault_docker_username }}"
    password: "{{ vault_docker_password }}"
  become_user: deploy
  when:
    - vault_docker_username is defined
    - vault_docker_password is defined
  tags: docker
```

## Purpose

Authenticates with Docker Hub.

Useful for:
- private images
- authenticated image pulls
- avoiding Docker Hub rate limits

## Variables

```yaml
{{ vault_docker_username }}
{{ vault_docker_password }}
```

Stored securely using Ansible Vault.

## become_user

```yaml
become_user: deploy
```

Runs Docker login as the deploy user instead of root.

## when

Runs only if credentials exist.

Prevents playbook failures.

---

# 6. Pull Application Image

```yaml
- name: Pull application image
  community.docker.docker_image:
    name: "{{ docker_app_image }}"
    tag: "{{ docker_app_tag }}"
    source: pull
  tags: docker
```

## Purpose

Downloads the Docker image.

Example variables:

```yaml
docker_app_image: nginx
docker_app_tag: latest
```

Equivalent command:

```bash
docker pull nginx:latest
```

---

# 7. Run Application Container

```yaml
- name: Run application container
  community.docker.docker_container:
    name: "{{ docker_app_name }}"
    image: "{{ docker_app_image }}:{{ docker_app_tag }}"
    state: started
    restart_policy: always
    published_ports:
      - "{{ docker_app_port }}:{{ docker_container_port }}"
  tags: docker
```

## Purpose

Creates and starts the Docker container.

## Example Variable Expansion

```yaml
docker_app_name: myapp
docker_app_image: nginx
docker_app_tag: latest
docker_app_port: 8080
docker_container_port: 80
```

Equivalent Docker command:

```bash
docker run -d \
  --name myapp \
  -p 8080:80 \
  --restart always \
  nginx:latest
```

## Port Mapping

```yaml
8080:80
```

Means:

| Host Port | Container Port |
|---|---|
| 8080 | 80 |

Browser traffic:

```text
http://server-ip:8080
```

is forwarded to container port 80.

## restart_policy

```yaml
restart_policy: always
```

Automatically restarts the container:
- after reboot
- after crashes
- after Docker restart

Common production practice.

---

# 8. Wait for Container Health Check

```yaml
- name: Wait for container to be healthy
  uri:
    url: "http://localhost:{{ docker_app_port }}"
    status_code: 200
  retries: 5
  delay: 3
  register: health_check
  until: health_check.status == 200
  tags: docker
```

## Purpose

Checks whether the application is responding correctly.

Equivalent command:

```bash
curl http://localhost:8080
```

## status_code

```yaml
status_code: 200
```

Expected successful HTTP response.

## Retry Logic

```yaml
retries: 5
delay: 3
```

Means:
- retry 5 times
- wait 3 seconds between attempts

Maximum wait time:

```text
15 seconds
```

## register

```yaml
register: health_check
```

Stores response data in a variable.

## until

```yaml
until: health_check.status == 200
```

Keep retrying until the application becomes healthy.

This is a common readiness-check pattern used in DevOps and automation.

---

# Summary

This Docker role:

- installs Docker
- starts Docker service
- adds deploy user to Docker group
- authenticates to Docker Hub
- pulls container images
- runs containers
- verifies application health

All tasks are tagged with:

```yaml
tags: docker
```

so they can be run independently.
