# Basic Docker — Roman Urdu Study Notes

## 1. Docker Kya Hai?

**Docker** ek containerization platform hai jo application ko us ki required dependencies ke sath package karta hai taa ke application different environments mein consistently run kar sake.

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

Is ka faida yeh hai ke application different environments mein same tarah run karti hai:

```text
Development → Testing → QA → Production
```

---

## 2. Docker Kyun Use Karte Hain?

Docker ke important faide:

- Consistent environments
- Fast deployment
- Application portability
- Lightweight isolation
- Easier scaling
- Dependency management easy hoti hai
- Microservices ke liye useful hai
- CI/CD workflows mein bohat common hai

### Example

Maan lein ek Python application ko chahiye:

- Python 3.12
- Flask
- Specific Python libraries
- Configuration files

Traditional setup mein har server par yeh sab manually install karna par sakta hai.

Docker mein application aur dependencies ko ek package mein rakha jata hai.

---

# 3. Important Docker Components

| Component | Roman Urdu Explanation |
|---|---|
| **Dockerfile** | Image banane ki instructions |
| **Docker Image** | Application ka packaged read-only template |
| **Docker Container** | Image ka running instance |
| **Docker Engine** | Containers ko run aur manage karta hai |
| **Docker Registry** | Docker images ko store karta hai |
| **Docker Hub** | Public online Docker registry |
| **Docker Volume** | Persistent data store karta hai |
| **Docker Network** | Containers ke darmiyan communication karwata hai |

---

# 4. Dockerfile

**Dockerfile** ek text file hoti hai jis mein Docker image banane ki instructions likhi hoti hain.

Example:

```dockerfile
FROM nginx:latest

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
```

### Important Dockerfile Instructions

| Instruction | Meaning |
|---|---|
| `FROM` | Base image define karta hai |
| `RUN` | Image build ke dauran command chalata hai |
| `COPY` | Files ko image ke andar copy karta hai |
| `WORKDIR` | Working directory set karta hai |
| `ENV` | Environment variable define karta hai |
| `EXPOSE` | Container port document karta hai |
| `CMD` | Default command define karta hai |
| `ENTRYPOINT` | Main executable define karta hai |

---

# 5. Docker Image

Docker **Image** ek packaged aur read-only template hoti hai jis se containers create hote hain.

Example:

```bash
docker pull nginx
```

Yeh command Nginx image download karegi.

Local images dekhne ke liye:

```bash
docker images
```

### Yaad Rakhein

```text
Image = Template / Blueprint
```

Image khud running application nahi hoti.

---

# 6. Docker Container

**Container** Docker image ka running instance hota hai.

Example:

```bash
docker run nginx
```

### Simple Difference

```text
Image      = Blueprint
Container  = Running Instance
```

Easy analogy:

```text
Image      = Recipe
Container  = Recipe se bana hua food
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

### Important Memory Trick

```text
Dockerfile → Build → Image → Run → Container
```

---

# 8. Docker Image Build Karna

Current directory ke Dockerfile se image build karne ke liye:

```bash
docker build -t myapp .
```

### Explanation

```text
docker build   = Image build karna
-t myapp       = Image ka naam myapp rakhna
.              = Current directory ko build context use karna
```

Image check karein:

```bash
docker images
```

---

# 9. Docker Container Run Karna

Image ko run karne ke liye:

```bash
docker run myapp
```

Background mein run karne ke liye:

```bash
docker run -d myapp
```

`-d` ka matlab:

```text
Detached Mode
```

Yani container background mein run karta rahega.

---

# 10. Docker Port Mapping

Example:

```bash
docker run -d -p 8080:80 nginx
```

Is ka matlab:

```text
Host Port        Container Port
8080        →     80
```

Browser mein access:

```text
http://localhost:8080
```

### General Syntax

```bash
docker run -p <host-port>:<container-port> <image>
```

---

# 11. Common Docker Commands

## Docker Version Check Karna

```bash
docker --version
```

---

## Image Download Karna

```bash
docker pull nginx
```

---

## Local Images Dekhna

```bash
docker images
```

---

## Running Containers Dekhna

```bash
docker ps
```

---

## Sab Containers Dekhna

```bash
docker ps -a
```

Is mein running aur stopped dono containers show hote hain.

---

## Container Run Karna

```bash
docker run nginx
```

---

## Background Mein Container Run Karna

```bash
docker run -d nginx
```

---

## Port Mapping Ke Sath Run Karna

```bash
docker run -d -p 8080:80 nginx
```

---

## Container Stop Karna

```bash
docker stop <container_id>
```

Example:

```bash
docker stop abc123
```

---

## Container Start Karna

```bash
docker start <container_id>
```

---

## Container Restart Karna

```bash
docker restart <container_id>
```

---

## Container Remove Karna

```bash
docker rm <container_id>
```

---

## Running Container Ko Force Remove Karna

```bash
docker rm -f <container_id>
```

---

## Docker Image Remove Karna

```bash
docker rmi <image_name>
```

Example:

```bash
docker rmi nginx
```

---

# 12. Docker Logs

Container ke logs dekhne ke liye:

```bash
docker logs <container_name>
```

Example:

```bash
docker logs myapp
```

Live logs follow karne ke liye:

```bash
docker logs -f myapp
```

Production troubleshooting mein yeh command bohat useful hai.

---

# 13. Running Container Ke Andar Jana

Running container ke andar Bash shell open karne ke liye:

```bash
docker exec -it <container_name> /bin/bash
```

Example:

```bash
docker exec -it webserver /bin/bash
```

Agar Bash available na ho:

```bash
docker exec -it webserver /bin/sh
```

### Explanation

```text
exec = Running container ke andar command chalana
-i   = Interactive mode
-t   = Terminal allocate karta hai
```

---

# 14. Docker Volumes

Containers temporary nature ke hote hain.

Agar important data sirf container ke andar ho aur container delete ho jaye, to data lose ho sakta hai.

Persistent data ke liye **Docker Volume** use hota hai.

Volume create karein:

```bash
docker volume create mydata
```

Volumes list karein:

```bash
docker volume ls
```

Volume inspect karein:

```bash
docker volume inspect mydata
```

Volume ke sath container run karein:

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

Docker networks containers ko ek doosre ke sath communicate karne deti hain.

Networks list:

```bash
docker network ls
```

Network create:

```bash
docker network create app-network
```

Container ko network ke sath run karein:

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

# 16. Container Ko Naam Dena

Docker ko random name generate karne dene ke bajaye hum khud container ka naam rakh sakte hain:

```bash
docker run -d --name webserver nginx
```

Ab hum naam use karke commands chala sakte hain:

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

# 17. Docker Inspect

Container ki detailed configuration dekhne ke liye:

```bash
docker inspect <container_name>
```

Example:

```bash
docker inspect webserver
```

Image inspect karne ke liye:

```bash
docker inspect nginx
```

---

# 18. Container Resource Usage

Container ki CPU aur memory usage dekhne ke liye:

```bash
docker stats
```

Yeh command information show karti hai:

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
| Containers create karne ke liye use hoti hai | Image se create hota hai |
| Running nahi hoti | Running process hota hai |
| Reusable hoti hai | Temporary nature ka ho sakta hai |
| Registry mein store hoti hai | Docker host par run karta hai |

### Interview Answer

> Docker image ek read-only template hoti hai jis mein application aur us ki dependencies hoti hain, jabke Docker container us image ka running instance hota hai.

---

# 20. Docker vs Virtual Machine

## Virtual Machine Architecture

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

## Docker Architecture

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
| Lightweight | Heavy hoti hai |
| Host kernel share karta hai | Apna Guest OS hota hai |
| Jaldi start hota hai | Start hone mein zyada time lag sakta hai |
| Kam storage leta hai | Zyada storage leta hai |
| Applications ke liye useful | Full OS isolation ke liye useful |
| Resources efficiently use karta hai | Zyada resources use karta hai |

---

# 21. Docker Registry

Docker Registry images ko store karti hai.

Examples:

- Docker Hub
- Amazon ECR
- Azure Container Registry
- Google Artifact Registry
- JFrog Artifactory

Image download:

```bash
docker pull nginx
```

Image upload:

```bash
docker push username/myapp:latest
```

---

# 22. Docker Tags

Tags image ke different versions identify karne ke liye use hote hain.

Example:

```bash
docker pull nginx:latest
```

```bash
docker pull nginx:1.27
```

Apni image ko tag karna:

```bash
docker tag myapp:latest username/myapp:v1
```

---

# 23. Container Lifecycle

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

Normally:

```bash
docker run
```

**create + start** dono ka kaam karta hai.

---

# 24. Docker Troubleshooting Commands

Running containers check karein:

```bash
docker ps
```

Sab containers check karein:

```bash
docker ps -a
```

Logs:

```bash
docker logs <container>
```

Live logs:

```bash
docker logs -f <container>
```

Configuration inspect:

```bash
docker inspect <container>
```

CPU aur memory check:

```bash
docker stats
```

Container shell:

```bash
docker exec -it <container> /bin/bash
```

Container ke processes:

```bash
docker top <container>
```

---

# 25. Beginner Practice Lab

## Step 1 — Nginx Image Pull Karein

```bash
docker pull nginx
```

## Step 2 — Image Check Karein

```bash
docker images
```

## Step 3 — Nginx Container Run Karein

```bash
docker run -d   --name my-nginx   -p 8080:80   nginx
```

## Step 4 — Container Check Karein

```bash
docker ps
```

## Step 5 — Browser Mein Test Karein

```text
http://localhost:8080
```

## Step 6 — Logs Check Karein

```bash
docker logs my-nginx
```

## Step 7 — Container Ke Andar Jayein

```bash
docker exec -it my-nginx /bin/bash
```

## Step 8 — Container Shell Se Exit Karein

```bash
exit
```

## Step 9 — Container Stop Karein

```bash
docker stop my-nginx
```

## Step 10 — Container Remove Karein

```bash
docker rm my-nginx
```

---

# 26. Important Interview Questions

## Q1. Docker kya hai?

Docker ek containerization platform hai jo applications ko un ki dependencies ke sath package aur run karne ke liye use hota hai.

---

## Q2. Docker image kya hoti hai?

Docker image ek read-only template hoti hai jis mein application, runtime, libraries aur dependencies hoti hain.

---

## Q3. Docker container kya hota hai?

Docker container image ka running instance hota hai.

---

## Q4. Image aur Container mein kya difference hai?

Image ek reusable template hoti hai, jabke container us image ka running instance hota hai.

---

## Q5. Dockerfile kya hai?

Dockerfile ek text file hoti hai jis mein Docker image build karne ki instructions hoti hain.

---

## Q6. `docker run` kya karta hai?

`docker run` image se naya container create aur start karta hai.

---

## Q7. `docker ps` aur `docker ps -a` mein kya difference hai?

```text
docker ps      = Sirf running containers
docker ps -a   = Running + stopped containers
```

---

## Q8. Docker Volume kya hai?

Docker Volume persistent storage provide karta hai jo container lifecycle se independent hoti hai.

---

## Q9. Docker containers lightweight kyun hote hain?

Docker containers host operating system ka kernel share karte hain aur har container ke liye separate full Guest OS run nahi karte.

---

## Q10. Container logs kaise check karte hain?

```bash
docker logs <container>
```

Live logs:

```bash
docker logs -f <container>
```

---

# 27. Quick Command Cheat Sheet

```bash
# Docker version
docker --version

# Image pull
docker pull nginx

# Images list
docker images

# Running containers
docker ps

# All containers
docker ps -a

# Container run
docker run nginx

# Background run
docker run -d nginx

# Port mapping
docker run -d -p 8080:80 nginx

# Container ko naam dena
docker run -d --name webserver nginx

# Stop
docker stop webserver

# Start
docker start webserver

# Restart
docker restart webserver

# Container remove
docker rm webserver

# Image remove
docker rmi nginx

# Logs
docker logs webserver

# Live logs
docker logs -f webserver

# Container shell
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

Sab se important flow:

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

Ya simple form mein:

```text
Dockerfile → Build → Image → Run → Container
```

### One-Line Interview Answer

> Docker ek containerization platform hai jo application aur us ki dependencies ko ek portable image mein package karta hai taa ke application different environments mein consistently run kar sake.

---

# Key Terms — Quick Revision

```text
Dockerfile = Image build karne ki instructions
Image      = Packaged template
Container  = Running image
Volume     = Persistent storage
Network    = Containers ki communication
Registry   = Images store karne ki jagah
```
