# Basic Docker — Study Notes

## 1. What is Docker?

**Docker** is a containerization platform that packages an application together with its required dependencies so that it can run consistently across different environments.

### Simple Idea

```text
Application
    +
Dependencies
    +
Runtime
    ↓
Docker Image
    ↓
Docker Container
```

This helps make the application behave consistently in:

```text
Development → Testing → QA → Production
```

---

## 2. Why Do We Use Docker?

Docker helps with:

- Consistent environments
- Faster deployment
- Application portability
- Lightweight isolation
- Easier scaling
- Simplified dependency management
- Microservices deployment
- CI/CD workflows

### Example

Suppose a Python application requires:

- Python 3.12
- Flask
- Specific Python libraries
- Configuration files

Instead of manually installing everything on every server, Docker packages these dependencies together with the application.

---

## 3. Important Docker Components

| Component | Purpose |
|---|---|
| **Dockerfile** | Instructions used to build a Docker image |
| **Docker Image** | Packaged, read-only application template |
| **Docker Container** | Running instance of an image |
| **Docker Engine** | Runs and manages Docker containers |
| **Docker Registry** | Stores Docker images |
| **Docker Hub** | Public cloud-based Docker registry |
| **Docker Volume** | Provides persistent data storage |
| **Docker Network** | Allows containers to communicate |

---

# 4. Dockerfile

A **Dockerfile** is a text file containing instructions for building a Docker image.

Example:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

### Important Dockerfile Instructions

| Instruction | Purpose |
|---|---|
| `FROM` | Defines the base image |
| `RUN` | Runs a command while building the image |
| `COPY` | Copies files into the image |
| `WORKDIR` | Sets the working directory |
| `ENV` | Defines environment variables |
| `EXPOSE` | Documents the container port |
| `CMD` | Defines the default command |
| `ENTRYPOINT` | Defines the main executable |

---

# 5. Docker Image

A Docker **image** is a packaged, read-only template used to create containers.

Example:

```bash
docker pull nginx
```

This downloads the Nginx image.

List local images:

```bash
docker images
```

### Key Point

```text
Image = Template / Blueprint
```

An image itself is not the running application.

---

# 6. Docker Container

A **container** is a running instance of a Docker image.

Example:

```bash
docker run nginx
```

### Key Point

```text
Image      = Blueprint
Container  = Running instance
```

Another easy analogy:

```text
Image      = Recipe
Container  = Prepared meal
```

---

# 7. Basic Docker Flow

```text
Dockerfile
    ↓
docker build
    ↓
Docker Image
    ↓
docker run
    ↓
Docker Container
```

### Remember

```text
Dockerfile → Build → Image → Run → Container
```

---

# 8. Building a Docker Image

Build an image from the Dockerfile in the current directory:

```bash
docker build -t myapp .
```

### Explanation

```text
docker build   = Build an image
-t myapp       = Give the image the name "myapp"
.              = Use the current directory as build context
```

Check the image:

```bash
docker images
```

---

# 9. Running a Docker Container

Run the image:

```bash
docker run myapp
```

Run it in the background:

```bash
docker run -d myapp
```

`-d` means:

```text
Detached mode
```

The container keeps running in the background.

---

# 10. Docker Port Mapping

Example:

```bash
docker run -d -p 8080:80 nginx
```

This means:

```text
Host Port        Container Port
8080        →     80
```

You can then access the application using:

```text
http://localhost:8080
```

### Syntax

```bash
docker run -p <host-port>:<container-port> <image>
```

---

# 11. Common Docker Commands

## Check Docker Version

```bash
docker --version
```

---

## Pull an Image

```bash
docker pull nginx
```

---

## List Images

```bash
docker images
```

---

## List Running Containers

```bash
docker ps
```

---

## List All Containers

```bash
docker ps -a
```

---

## Run a Container

```bash
docker run nginx
```

---

## Run in Detached Mode

```bash
docker run -d nginx
```

---

## Run with Port Mapping

```bash
docker run -d -p 8080:80 nginx
```

---

## Stop a Container

```bash
docker stop <container_id>
```

Example:

```bash
docker stop abc123
```

---

## Start an Existing Container

```bash
docker start <container_id>
```

---

## Restart a Container

```bash
docker restart <container_id>
```

---

## Remove a Container

```bash
docker rm <container_id>
```

---

## Force Remove a Running Container

```bash
docker rm -f <container_id>
```

---

## Remove an Image

```bash
docker rmi <image_name>
```

Example:

```bash
docker rmi nginx
```

---

# 12. Viewing Container Logs

View logs:

```bash
docker logs <container_name>
```

Example:

```bash
docker logs myapp
```

Follow logs in real time:

```bash
docker logs -f myapp
```

This is especially useful during troubleshooting.

---

# 13. Accessing a Running Container

Open a Bash shell inside a running container:

```bash
docker exec -it <container_name> /bin/bash
```

Example:

```bash
docker exec -it webserver /bin/bash
```

If Bash is not installed:

```bash
docker exec -it webserver /bin/sh
```

### Explanation

```text
exec  = Execute a command inside running container
-i    = Interactive mode
-t    = Allocate a terminal
```

---

# 14. Docker Volumes

Containers are usually considered temporary.

If important application data exists only inside the container, deleting the container may remove that data.

For persistent data, Docker uses **volumes**.

Create a volume:

```bash
docker volume create mydata
```

List volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect mydata
```

Run a container with a volume:

```bash
docker run -d   -v mydata:/data   myapp
```

### Concept

```text
Container
    |
    ↓
Docker Volume
    |
Persistent Data
```

---

# 15. Docker Networking

Docker networks allow containers to communicate with each other.

List networks:

```bash
docker network ls
```

Create a network:

```bash
docker network create app-network
```

Run a container on the network:

```bash
docker run -d   --name web   --network app-network   nginx
```

### Example Architecture

```text
User
 |
 ↓
Web Container
 |
 ↓
Application Container
 |
 ↓
Database Container
```

---

# 16. Naming a Container

Instead of allowing Docker to generate a random name:

```bash
docker run -d --name webserver nginx
```

Now commands can use the name:

```bash
docker stop webserver
```

```bash
docker logs webserver
```

```bash
docker exec -it webserver /bin/bash
```

---

# 17. Inspecting Docker Resources

Inspect a container:

```bash
docker inspect <container_name>
```

Example:

```bash
docker inspect webserver
```

Inspect an image:

```bash
docker inspect nginx
```

---

# 18. Container Resource Usage

Check CPU and memory usage:

```bash
docker stats
```

This shows information such as:

- CPU usage
- Memory usage
- Network I/O
- Block I/O
- Process count

---

# 19. Docker Image vs Container

| Docker Image | Docker Container |
|---|---|
| Read-only template | Running instance |
| Used to create containers | Created from an image |
| Not running | Active process |
| Reusable | Temporary by nature |
| Stored in registry | Runs on Docker host |

### Interview Answer

> A Docker image is a read-only template that contains the application and its dependencies, while a Docker container is a running instance of that image.

---

# 20. Docker vs Virtual Machine

## Virtual Machine

```text
Hardware
   ↓
Host OS
   ↓
Hypervisor
   ↓
Guest OS
   ↓
Application
```

## Docker

```text
Hardware
   ↓
Host OS
   ↓
Docker Engine
   ↓
Containers
```

| Docker Container | Virtual Machine |
|---|---|
| Lightweight | Heavier |
| Shares host kernel | Has its own guest OS |
| Starts quickly | Slower startup |
| Smaller image size | Often requires more storage |
| Great for applications | Great for full OS isolation |
| Efficient resource usage | Higher resource usage |

---

# 21. Docker Registry

A Docker registry stores Docker images.

Examples include:

- Docker Hub
- Amazon ECR
- Azure Container Registry
- Google Artifact Registry
- JFrog Artifactory

Download an image:

```bash
docker pull nginx
```

Upload an image:

```bash
docker push username/myapp:latest
```

---

# 22. Docker Tags

Tags identify different versions of an image.

Example:

```bash
docker pull nginx:latest
```

```bash
docker pull nginx:1.27
```

Tag your own image:

```bash
docker tag myapp:latest username/myapp:v1
```

---

# 23. Important Container Lifecycle

```text
Create
  ↓
Start
  ↓
Running
  ↓
Stop
  ↓
Stopped
  ↓
Remove
```

Useful commands:

```bash
docker create nginx
docker start <id>
docker stop <id>
docker rm <id>
```

Normally, `docker run` combines **create + start**.

---

# 24. Useful Troubleshooting Commands

Check running containers:

```bash
docker ps
```

Check all containers:

```bash
docker ps -a
```

Check logs:

```bash
docker logs <container>
```

Follow logs:

```bash
docker logs -f <container>
```

Inspect configuration:

```bash
docker inspect <container>
```

Check resource usage:

```bash
docker stats
```

Open a shell:

```bash
docker exec -it <container> /bin/bash
```

Check container processes:

```bash
docker top <container>
```

---

# 25. Beginner Practice Lab

## Step 1 — Pull Nginx

```bash
docker pull nginx
```

## Step 2 — Check Image

```bash
docker images
```

## Step 3 — Run Nginx

```bash
docker run -d   --name my-nginx   -p 8080:80   nginx
```

## Step 4 — Check Container

```bash
docker ps
```

## Step 5 — Test in Browser

Open:

```text
http://localhost:8080
```

## Step 6 — Check Logs

```bash
docker logs my-nginx
```

## Step 7 — Enter Container

```bash
docker exec -it my-nginx /bin/bash
```

## Step 8 — Exit Container

```bash
exit
```

## Step 9 — Stop Container

```bash
docker stop my-nginx
```

## Step 10 — Remove Container

```bash
docker rm my-nginx
```

---

# 26. Important Interview Questions

## Q1. What is Docker?

Docker is a containerization platform used to package and run applications together with their dependencies in isolated containers.

---

## Q2. What is a Docker image?

A Docker image is a read-only template containing the application, runtime, libraries, configuration, and dependencies required to create containers.

---

## Q3. What is a Docker container?

A Docker container is a running instance of a Docker image.

---

## Q4. What is the difference between an image and a container?

An image is a reusable template, while a container is the running instance created from that image.

---

## Q5. What is a Dockerfile?

A Dockerfile is a text file that contains instructions Docker follows to build an image.

---

## Q6. What does `docker run` do?

`docker run` creates and starts a new container from an image.

---

## Q7. What is the difference between `docker ps` and `docker ps -a`?

```text
docker ps      = Shows running containers
docker ps -a   = Shows running and stopped containers
```

---

## Q8. What is a Docker volume?

A Docker volume provides persistent storage that exists independently of the container lifecycle.

---

## Q9. Why are Docker containers lightweight?

Containers share the host operating system kernel instead of running a complete guest operating system like traditional virtual machines.

---

## Q10. How do you check container logs?

```bash
docker logs <container>
```

For live logs:

```bash
docker logs -f <container>
```

---

# 27. Quick Command Cheat Sheet

```bash
# Docker version
docker --version

# Pull image
docker pull nginx

# List images
docker images

# List running containers
docker ps

# List all containers
docker ps -a

# Run a container
docker run nginx

# Run in background
docker run -d nginx

# Port mapping
docker run -d -p 8080:80 nginx

# Name a container
docker run -d --name webserver nginx

# Stop
docker stop webserver

# Start
docker start webserver

# Restart
docker restart webserver

# Remove container
docker rm webserver

# Remove image
docker rmi nginx

# Logs
docker logs webserver

# Live logs
docker logs -f webserver

# Shell into container
docker exec -it webserver /bin/bash

# Resource usage
docker stats

# Inspect
docker inspect webserver

# Volumes
docker volume ls

# Networks
docker network ls
```

---

# 28. Final Memory Trick

Remember this flow:

```text
Dockerfile
   ↓
Build
   ↓
Image
   ↓
Run
   ↓
Container
```

Or simply:

```text
Dockerfile → Build → Image → Run → Container
```

### One-Line Interview Answer

> Docker is a containerization platform that packages an application with its dependencies into a portable image so that it can run consistently across different environments.

---

## Key Terms to Remember

```text
Dockerfile = Build instructions
Image      = Packaged template
Container  = Running image
Volume     = Persistent storage
Network    = Container communication
Registry   = Image storage
```
