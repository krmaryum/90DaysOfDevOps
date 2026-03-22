# Docker Commands Cheat Sheet

## Running Containers

| Task | Command |
|------|---------|
| Run container | `docker run nginx` |
| Run detached | `docker run -d nginx` |
| Run with name | `docker run --name my-nginx -d nginx` |
| Port mapping | `docker run -p 8080:80 nginx` |
| Environment variable | `docker run -e NODE_ENV=production my-app` |
| Multiple env vars | `docker run -e DB_HOST=localhost -e DB_PORT=5432 my-app` |
| Bind mount volume | `docker run -v $(pwd):/app my-app` |
| Named volume | `docker run -v my-volume:/data my-app` |
| Interactive shell | `docker run -it ubuntu bash` |
| Auto-remove on stop | `docker run --rm nginx` |
| Set restart policy | `docker run --restart=always nginx` |
| Limit memory | `docker run -m 512m nginx` |
| Limit CPU | `docker run --cpus="1.5" nginx` |

---

## Managing Containers

| Task | Command |
|------|---------|
| List running containers | `docker ps` |
| List all containers | `docker ps -a` |
| Stop container | `docker stop <container_id>` |
| Start container | `docker start <container_id>` |
| Remove container | `docker rm <container_id>` |
| Exec into container | `docker exec -it <container_id> bash` |
| View logs | `docker logs <container_id>` |
| Attach to running container | `docker attach <container_id>` |
| Inspect container | `docker inspect <container_id>` |
| Copy files to container | `docker cp localfile <container_id>:/path` |

---

## Image Commands

| Task | Command |
|------|---------|
| Build image | `docker build -t my-app:v1 .` |
| List images | `docker images` |
| Pull image | `docker pull nginx` |
| Push image | `docker push username/my-app:v1` |
| Remove image | `docker rmi <image_id>` |
| Tag image | `docker tag my-app:v1 username/my-app:v1` |
| Inspect image | `docker inspect <image_id>` |
| History of image | `docker history <image_id>` |

---

## Volumes

| Task | Command |
|------|---------|
| Create volume | `docker volume create my-vol` |
| List volumes | `docker volume ls` |
| Inspect volume | `docker volume inspect my-vol` |
| Remove volume | `docker volume rm my-vol` |
| Prune unused volumes | `docker volume prune` |

---

## Networks

| Task | Command |
|------|---------|
| Create network | `docker network create app-net` |
| List networks | `docker network ls` |
| Inspect network | `docker network inspect app-net` |
| Connect container to network | `docker network connect app-net <container>` |
| Disconnect container | `docker network disconnect app-net <container>` |

---

## Docker Compose

| Task | Command |
|------|---------|
| Start services | `docker compose up -d` |
| Stop services | `docker compose down` |
| Stop & remove volumes | `docker compose down -v` |
| List services | `docker compose ps` |
| Build services | `docker compose build` |
| View logs | `docker compose logs` |
| Recreate services | `docker compose up -d --build` |
| Scale a service | `docker compose up -d --scale web=3` |

---

## Cleanup & System

| Task | Command |
|------|---------|
| Remove unused containers, networks, images | `docker system prune` |
| Show disk usage | `docker system df` |
| Remove unused images | `docker image prune` |
| Remove unused volumes | `docker volume prune` |
| Remove all stopped containers | `docker container prune` |
| Remove all unused networks | `docker network prune` |

---

## Dockerfile Instructions

| Instruction | Purpose |
|-------------|---------|
| FROM | Set base image |
| WORKDIR | Set working directory |
| COPY | Copy files/folders into image |
| ADD | Copy files + supports URLs & auto-extract |
| RUN | Execute command during build |
| CMD | Default command when container starts |
| ENTRYPOINT | Fixed executable command |
| EXPOSE | Inform about port used |
| ENV | Set environment variable inside image |
| ARG | Build-time argument |
| USER | Switch user |
| VOLUME | Declare mount point for volumes |
| HEALTHCHECK | Set health check for container |
