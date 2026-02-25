# Day 29 - Docker Basics Quick Reference

------------------------------------------------------------------------

## Task 1 - Docker Fundamentals

| Topic               | Key Points                                            |
|---------------------|-------------------------------------------------------|
| Container           | Lightweight package with application and dependencies |
| Why Containers      | Solve "It works on my machine" problem                |
| VM vs Container     | VMs include full OS, containers share host kernel     |
| Docker Architecture | Client → Daemon → Registry → Image → Container        |

------------------------------------------------------------------------

## Task 2 - Installation & First Run

| Command                  | Purpose                   |
|--------------------------|---------------------------|
| `docker --version`       | Check Docker installation |
| `docker info`            | Verify daemon is running  |
| `docker run hello-world` | Test container execution  |

------------------------------------------------------------------------

## Task 3 - Running Real Containers

| Command                          | Purpose                                   |
|----------------------------------|-------------------------------------------|
| `docker run -d -p 8080:80 nginx` | Run Nginx in background with port mapping |
| `docker run -it ubuntu`          | Interactive Ubuntu container              |
| `docker ps`                      | List running containers                   |
| `docker ps -a`                   | List all containers                       |
| `docker stop <name>`             | Stop container                            |
| `docker rm <name>`               | Remove container                          |

------------------------------------------------------------------------

## Task 4 - Exploration

| Feature             | Command                       |
|---------------------|-------------------------------|
| Detached Mode       | `docker run -d nginx`         |
| Custom Name         | `--name my-container`         |
| Port Mapping        | `-p host:container`           |
| View Logs           | `docker logs <name>`          |
| Live Logs           | `docker logs -f <name>`       |
| Exec into Container | `docker exec -it <name> bash` |

------------------------------------------------------------------------

## Task 5 - Cleanup

| Task                        | Command                       |
|-----------------------------|-------------------------------|
| Stop all running containers | `docker stop $(docker ps -q)` |
| Remove stopped containers   | `docker container prune`      |
| Remove unused images        | `docker image prune -a`       |
| Check disk usage            | `docker system df`            |
| Full cleanup (careful)      | `docker system prune -a`      |

------------------------------------------------------------------------

## Core Flags Used

| Flag     | Meaning               |
|----------|-----------------------|
| `-d`     | Detached mode         |
| `-it`    | Interactive terminal  |
| `-p`     | Port mapping          |
| `--name` | Custom container name |
| `-f`     | Force removal         |
