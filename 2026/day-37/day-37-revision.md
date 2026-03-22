# Day 37 – Docker Revision

## Self-Assessment

- [x] Run a container from Docker Hub (interactive + detached)
- [x] List, stop, remove containers and images
- [x] Explain image layers and how caching works
- [x] Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD
- [x] Explain CMD vs ENTRYPOINT
- [x] Build and tag a custom image
- [x] Create and use named volumes
- [x] Use bind mounts
- [x] Create custom networks and connect containerss
- [x] Write a docker-compose.yml for a multi-container app
- [x] Use environment variables and .env files in Compose
- [x] Write multi-stage Dockerfile
- [x] Push an image to Docker Hub
- [x] Use healthchecks and depends_on

---

## Quick-Fire Answers

### 1. What is the difference between an image and a container?
Image = blueprint (read-only)
Container = running instance of an image

---

### 2. What happens to data inside a container when you remove it?
Data is lost unless stored in a volume or bind mount

---

### 3. How do two containers on the same custom network communicate?
They communicate using container names as hostnames

---

### 4. What does ``docker compose down -v`` do differently from ``docker compose down``?
down → removes containers + network
down -v → also removes volumes (data loss)

---

### 5. Why are multi-stage builds useful?
Reduce image size by keeping only necessary build artifacts

---

### 6. What is the difference between ``COPY`` vs ``ADD``
COPY → simple file copy
ADD → supports URLs + auto extract (less predictable)

---

### 7. What does ``-p 8080:80`` mean?
Host port 8080 → Container port 80

---

### 8. How do you check how much disk space Docker is using?
docker system df

---

## Weak Areas Revisited

### Topic 1: Multi-Stage Builds
- Practiced building Node.js app with builder + production stage
- Observed reduced image size

### Topic 2: Networking
- Created custom bridge network
- Connected multiple containers
- Verified communication using curl

---

## Highlights
- Containers are ephemeral → volumes are critical
- Networks enable service discovery
- Smaller images = faster deploys
- Compose simplifies multi-container setups

---

