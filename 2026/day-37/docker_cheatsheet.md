# 🐳 Docker Cheat Sheet

## Quick Commands Table (Day 37 – Docker)

| Category | Command | Description |
|----------|--------|-------------|
| System Check | `docker --version` | Check Docker version |
| System Info | `docker info` | Show Docker system details |
| Images | `docker pull <image>` | Download image from Docker Hub |
| Images | `docker images` | List all images |
| Images | `docker rmi <image>` | Remove image |
| Containers | `docker run <image>` | Create + start container |
| Containers | `docker run -it <image> bash` | Run interactive container |
| Containers | `docker run -d <image>` | Run container in background |
| Ports | `docker run -p 8080:80 <image>` | Map host port to container |
| Containers | `docker ps` | List running containers |
| Containers | `docker ps -a` | List all containers |
| Containers | `docker stop <container>` | Stop container |
| Containers | `docker start <container>` | Start container |
| Containers | `docker rm <container>` | Remove container |
| Build | `docker build -t my-app .` | Build image from Dockerfile |
| Volumes | `docker volume create <name>` | Create named volume |
| Volumes | `docker run -v <vol>:/path` | Attach volume to container |
| Volumes | `docker run -v $(pwd):/app` | Bind mount local directory |
| Network | `docker network ls` | List networks |
| Network | `docker network create <name>` | Create custom network |
| Network | `docker run --network <name>` | Connect container to network |
| Compose | `docker-compose up` | Start services |
| Compose | `docker-compose up -d` | Start in background |
| Compose | `docker-compose down` | Stop services |
| Compose | `docker compose down -v` | Stop + remove volumes |
| Debug | `docker logs <container>` | View container logs |
| Debug | `docker exec -it <container> bash` | Enter running container |
| Debug | `docker inspect <container>` | Show container details |
| Cleanup | `docker system prune` | Remove unused resources |
| Cleanup | `docker system prune -a` | Remove all unused data |
| Disk | `docker system df` | Check Docker disk usage |
| Danger | `docker rm $(docker ps -qa)` | Remove ALL containers ⚠️ |
| Danger | `docker rmi $(docker images -q)` | Remove ALL images ⚠️ |

## 🔹 Core Concepts

- **Image** → Blueprint (read-only)
- **Container** → Running instance of an image
- **Dockerfile** → Instructions to build an image
- **Volume** → Persistent storage
- **Network** → Communication layer between containers

---

## 🔹 Basic Commands

### Docker Version & Info
```bash
docker --version       # Check installed Docker version
docker info            # Detailed system + Docker config info
```

### Images
```bash
docker pull <image>   # Download image from Docker Hub
docker images         # List all local images
docker rmi <image>    # Remove image (must not be used by container)
docker rmi $(docker images -q)
```

### Containers
```bash
docker run <image>               # Create + start container
docker run -it <image> bash      # Interactive shell inside container
docker run -d -p 8080:80 <image> # Interactive shell inside container
docker ps                        # Show running containers
docker ps -a                     # Show all (including stopped)
docker stop <container>          # Stop running container
docker start <container>         # Restart stopped container
docker rm <container>            # Delete container
docker rm $(docker ps -qa)
```

---

## 🔹 Running Containers

### Interactive Mode  **Use for debugging / learning inside container**
```bash
docker run -it ubuntu bash
```

### Detached Mode   **Run web server in background**
```bash
docker run -d nginx
```

### Port Mapping   **Access app via localhost:3000**
```bash
docker run -p 3000:3000 node-app
```

---

## 🔹 Dockerfile Basics

```Dockerfile
FROM node:18
# Base image

WORKDIR /app
# Set working directory

COPY package.json .
# Copy dependency file first (for caching)

RUN npm install
# Install dependencies

COPY . .
# Copy rest of code

CMD ["npm", "start"]
```
Default command when container runs

### Build Image  **# Build image with name 'my-app'**
```bash
docker build -t my-app .
```

---

## 🔹 Volumes

### Create Volume    **Create persistent storage**
```bash
docker volume create my-volume
```

### Use Volume       **Attach volume to container**
```bash
docker run -v my-volume:/data busybox
```

### Bind Mount       **Bind local folder to container**
```bash
docker run -v $(pwd):/app node-app
```

---

## 🔹 Networking

### List Networks
```bash
docker network ls
```

### Create Network
```bash
docker network create my-network
```

### Run Container in Network   **Connect container to network**
```bash
docker run --network my-network nginx
```

---

## 🔹 Docker Compose

### Start Services     **Build + start all services**
```bash
docker-compose up
```

### Detached Mode      **Build + start all services + Run in background**
```bash
docker-compose up -d
```

### Stop + Remove all Services
```bash
docker-compose down
```

---

## 🔹 Cleanup

```bash
docker system prune     # Remove everything unused (⚠️ careful)
docker container prune  # Remove stopped containers
docker image prune      # Remove unused images only
```

---

## 🔹 Debugging

```bash
docker logs <container>            # View logs the <container>
docker exec -it <container> bash   # Enter running container
docker inspect <container>         # Full metadata (JSON) 
```

---

## Mental Model Tips (Inline Thinking)
- `run = create + start`
- `-it = interactive`
- `-d = background`
- `-p = expose to outside world`
- `-v = persistence`
- `network = communication between containers`

---

## ☠️ Danger Zone (Use With Caution)
Quick Insight
- $(...) → runs a command inside another command
- docker ps -qa → gets all container IDs
- docker images -q → gets all image IDs

### 🚨 Deletes ALL containers (running + stopped)
```bash
docker rm $(docker ps -qa)
```

### 🚨 Deletes ALL images (may fail if containers exist)
```bash
docker rmi $(docker images -q)
```

### 🚨 Force remove ALL containers (even running)
```bash
docker rm -f $(docker ps -qa)
```

### 🚨 Remove ALL unused data (containers, images, networks, build cache)
```bash
docker system prune -a
```

## 🔹 Pro Tips

- Use `.dockerignore` to reduce build size
- Keep images small (use alpine)
- Use multi-stage builds
- Always name containers clearly
- Use environment variables for configs

---

## 🔹 Common Flags

| Flag | Meaning |
|------|--------|
| `-d` | Detached mode |
| `-it` | Interactive terminal |
| `-p` | Port mapping |
| `-v` | Volume |
| `--name` | Name container |
| `--network` | Specify network |

---

##  Quick Command Reference Table

| Command | Description |
|--------|-------------|
| `docker --version` | Show Docker version |
| `docker info` | Show system-wide info |
| `docker pull <image>` | Download image |
| `docker images` | List images |
| `docker rmi <image>` | Remove image |
| `docker run <image>` | Run container |
| `docker run -it <image> bash` | Interactive container |
| `docker run -d <image>` | Run in background |
| `docker run -p host:container <image>` | Map ports |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers |
| `docker stop <container>` | Stop container |
| `docker start <container>` | Start container |
| `docker rm <container>` | Remove container |
| `docker build -t name .` | Build image from Dockerfile |
| `docker volume create <name>` | Create volume |
| `docker network ls` | List networks |
| `docker network create <name>` | Create network |
| `docker exec -it <container> bash` | Access container shell |
| `docker logs <container>` | View logs |
| `docker-compose up` | Start services |
| `docker-compose up -d` | Start in background |
| `docker-compose down` | Stop services |
| `docker system prune` | Clean unused resources |
| `docker image prune` | Remove unused images |
| `docker container prune` | Remove stopped containers |

---

# Docker Compose (with Inline Comments)

```yaml
version: "3.9"  # Compose file version

services:
  app:
    build: .                 # Build from Dockerfile in current folder
    container_name: node-app
    ports:
      - "3000:3000"          # host:container → access via localhost:3000
    volumes:
      - .:/app               # Bind mount (live code changes)
    environment:
      - NODE_ENV=development # Set env variable inside container
    depends_on:
      - db                   # Start db before app (not full readiness)
    networks:
      - my-network           # Connect to custom network

  db:
    image: mongo             # Use official MongoDB image
    container_name: mongo-db
    ports:
      - "27017:27017"        # Default Mongo port
    volumes:
      - mongo-data:/data/db  # Named volume for persistence
    networks:
      - my-network

volumes:
  mongo-data:                # Define named volume

networks:
  my-network:                # Define custom network
```

---

## Key Compose Insights (Inline Thinking)

* `build:` → use your Dockerfile
* `image:` → pull from Docker Hub
* `depends_on` ≠ wait until ready (only start order)
* `volumes` → persistence OR live reload
* `networks` → containers talk using service name (`db`, `app`)

---

# Multi-Stage Dockerfile (with Inline Comments)

```Dockerfile
# ---------- Stage 1: Build ----------
FROM node:18 AS builder          # First stage (build environment)

WORKDIR /app

COPY package.json .              # Copy dependencies first (cache optimization)
RUN npm install                  # Install all dependencies

COPY . .                         # Copy full app source
RUN npm run build                # Build app (e.g., React/Node build)

# ---------- Stage 2: Production ----------
FROM node:18-alpine              # Lightweight production image

WORKDIR /app

COPY --from=builder /app .       # Copy built app from builder stage

RUN npm install --only=production  # Install only production deps

CMD ["node", "server.js"]        # Start app
```

---

## Multi-Stage Mental Model

* Stage 1 → **heavy (build tools, dev deps)**
* Stage 2 → **light (only what’s needed to run)**
* `--from=builder` → copy only final output

---

##  Why This Matters (Interview + Real World)

* Smaller image size 
* Faster deployments
* Cleaner production environments
* Industry standard practice

---

## Mini Challenge (Do This Once)

1. Create:

   * Node app
   * Mongo DB
2. Write:

   * Dockerfile
   * docker-compose.yml
3. Add:

   * Volume for DB
   * Env file
4. Run:

```bash
docker-compose up -d
```

---

# Docker Self-Assessment Checklist

## Instructions

Mark honestly by checking one option per skill:

* [ ] Can Do
* [ ] Shaky
* [ ] Haven’t Done

---

## 🔍 Skills Checklist

### 1. Run a container (interactive + detached)

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 2. List, stop, remove containers and images

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 3. Explain image layers & caching

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 4. Write a Dockerfile (FROM, RUN, COPY, WORKDIR, CMD)

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 5. Explain CMD vs ENTRYPOINT

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 6. Build and tag a custom image

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 7. Create and use named volumes

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 8. Use bind mounts

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 9. Create custom networks & connect containers

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 10. Write docker-compose.yml (multi-container app)

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 11. Use environment variables & `.env` in Compose

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 12. Write a multi-stage Dockerfile

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 13. Push image to Docker Hub

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

### 14. Use healthchecks & depends_on

* [X] Can Do
* [ ] Shaky
* [ ] Haven’t Done

---

## Score Yourself

* **12–14 Can Do** →  Project Ready

---

# Docker Quick-Fire Questions

## Instructions

1. Answer from memory (don’t scroll down)
2. Then check the answers section
3. Mark yourself: ✅ / ⚠️ / ❌

---

#  Answers (Verify After)

### 1. Image vs Container

* Image = blueprint (read-only)
* Container = running instance of image

---

### 2. Data inside container

* Deleted when container is removed
* Unless stored in **volume or bind mount**

---

### 3. Container communication

* Via **service/container name**
* Uses Docker internal DNS on same network

---

### 4. `down` vs `down -v`

* `docker compose down` → removes containers, networks
* `docker compose down -v` → ALSO removes volumes (⚠️ data loss)

---

### 5. Multi-stage builds

* Reduce image size
* Separate build + production environments
* Remove unnecessary dependencies

---

### 6. COPY vs ADD

* COPY → simple file copy (recommended)
* ADD → extra features (auto-extract tar, remote URLs)

---

### 7. `-p 8080:80`

* Maps **host:container**
* Access container via `localhost:8080`

---

### 8. Docker disk usage

```bash
docker system df
```

---

## Self-Evaluation

* ✅ Got it right → Solid

---

#  Docker Flashcards

## Basics

Q: What is docker run?\
A: create + start container

Q: What is docker ps?\
A: list running containers

Q: What is docker ps -a?\
A: list all containers

---

## Modes

Q: What does -it do?\
A: interactive terminal

Q: What does -d do?\
A: run in background

Q: What does -p 8080:80 mean?\
A: host 8080 → container 80

---

## Images

Q: How to download image?\
A: docker pull

Q: How to list images?\
A: docker images

Q: How to remove image?\
A: docker rmi

---

## Volumes

Q: Why use volumes?\
A: persist data

Q: Bind mount vs volume?\
A: local vs Docker-managed

---

## Networking

Q: How containers communicate?\
A: same network via name

---

## Compose

Q: docker-compose up?\
A: start services

Q: down vs down -v?\
A: -v removes volumes

---

## Debugging

Q: View logs?\
A: docker logs

Q: Enter container?\
A: docker exec -it

---

## Cleanup

Q: Check disk usage?\
A: docker system df

Q: Clean system?\
A: docker system prune

---

## Danger

Q: Remove all containers?\
A: docker rm $(docker ps -qa)

Q: Remove all images?\
A: docker rmi $(docker images -q)

---

💡 Rule: If you can answer these fast → you actually know Docker



