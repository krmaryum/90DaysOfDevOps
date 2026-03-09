# Day 33 – Docker Compose: Multi-Container Basics

## Table of Contents

- [Goal](#goal)
- [Why Docker Compose](#why-docker-compose)

### Tasks
- [Task 1: Install & Verify](#task-1-install--verify)
- [Task 2: My First Compose File](#task-2-my-first-compose-file)
- [Task 3: Two-Container Setup](#task-3-two-container-setup)
- [Task 4: Docker Compose Commands](#task-4-docker-compose-commands)
- [Task 5: Environment Variables](#task-5-environment-variables)

### Other Sections
- [Quick Command Summary](#quick-command-summary)

Docker Compose automates the creation, configuration, and running of multiple Docker containers using a YAML file.

| Feature    | Docker               | Docker Compose           |
| ---------- | -------------------- | ------------------------ |
| Purpose    | Run single container | Run multi-container apps |
| Config     | CLI commands         | YAML file                |
| Scaling    | Manual               | Easy                     |
| Networking | Manual               | Automatic                |
| Use Case   | Simple containers    | Microservices apps       |

## Goal
Run a multi-container application with a single command using **Docker Compose**.

## Why Compose?
Compose lets you define:
- **services** (containers),
- **networks** (Compose creates a default network automatically),
- **volumes** (for persistent data),
all in one `docker-compose.yml` file — then bring it all up/down with a single command.

Key behavior:
- Compose creates a **default network** per project.
- **Service names become DNS names** (e.g., `redis`, `db`) inside the network.
- `depends_on` controls **startup order** (not readiness).

---

## Quick Command Summary

| Task                                   | Command                                                                 |
| -------------------------------------- | ----------------------------------------------------------------------- |
| Start services in detached mode        | `docker compose up -d`                                                  |
| View running services                  | `docker compose ps`                                                     |
| View logs (all services)               | `docker compose logs`                                                   |
| Follow logs in real time               | `docker compose logs -f`                                                |
| View logs of a specific service        | `docker compose logs SERVICE_NAME`                                      |
| Stop services (keep containers)        | `docker compose stop`                                                   |
| Start stopped services                 | `docker compose start`                                                  |
| Stop and remove containers + networks  | `docker compose down`                                                   |
| Remove containers + networks + volumes | `docker compose down -v`                                                |
| Rebuild containers after changes       | `docker compose up -d --build`                                          |
| Run a specific compose file            | `docker compose -f docker-compose-dot-env.yml up -d`                    |
| Use multiple compose files             | `docker compose -f docker-compose.yml -f docker-compose.prod.yml up -d` |
| Validate and view merged configuration | `docker compose config`                                                 |


---


## Task 1: Install & Verify

### Check Compose availability
```bash
docker compose version
```
```text
Docker Compose version v5.1.0
```

### If the command is missing
- **Docker Desktop (Mac/Windows):** Compose is bundled — install/update Docker Desktop.
- **Linux:** Use the official Docker Engine + Compose plugin packages for your distro.

---

## Task 2: My First Compose File
### 1. Create a folder `compose-basics`
```bash
mkdir compose-basics && cd compose-basics
```

### 2. Create a `docker-compose.yml`
that runs a single Nginx container with port mapping
```bash
vim docker-compose.yml
```
```YAML
services:
  nginx:
    image: nginx:latest
    container_name: compose-nginx
    ports:
      - "8080:80"
```
### What this does
- image: pulls the official Nginx image
- ports: maps
  - host 8080 → container 80

When open the browser, will access the Nginx web serve

### Equivalent Docker CLI Command
```bash
docker run -d --name compose-nginx -p 8080:80 nginx:latest
```
### Always validate your compose file with:
```bash
docker compose config
```
Shows parsed configuration.

If there is an error, Docker tells you the line number.

### Golden Rule for YAML
```text
Spaces matter
Indentation matters
Lists need "-"
```

### 3. Start the container
```bash
docker compose up -d
```
Check running containers:
```bash
docker compose ps
```


### 4. Access in the browser
Open:
```bash
http://localhost:8080
```
![first docker-compose](screenshots/day-33-1-nginx.png)

### 5. View logs 
```bash
docker compose logs -f
```

### 6. Stop the container
```bash
docker compose down
```
![nginx](screenshots/day-33-2-nginx-down.png)

---

## Task 3: Two-Container Setup
- WordPress container → runs the website application
- MySQL container → stores the website’s data
They work together to run a complete website.

### 1. Create `docker-compose.yml`
```bash
vim docker-compose.yml
```
```YAML
---
services:                            # is the main section in Docker Compose where containers of the application are defined.
  db:                                # This the service name representing the database container.
    image: mysql:8.4                 # means the container runs using the MySQL version 8.4 image.
    restart: unless-stopped          # The container will automatically restart if it stops or crashes, unless it is manually stopped.
    environment:                     # Environment Variables (Database Setup)
      MYSQL_DATABASE: wordpress      # name of the WordPress database
      MYSQL_USER: wpuser             # database username
      MYSQL_PASSWORD: wppass         # password for the user
      MYSQL_ROOT_PASSWORD: rootpass  # admin (root) password for MySQL
    volumes:                         # This ensures persistent storage for the database.
      - db_data:/var/lib/mysql       # is the default directory where MySQL stores data.

  wordpress:
    image: wordpress:6-php8.2-apache
    restart: unless-stopped
    depends_on:                      # This means the WordPress container starts after the db container.
      - db                           # The database must be available first.
    ports:
      - "8081:80"                    # Maps host port 8081 to container port 80.
    environment:
      WORDPRESS_DB_HOST: db:3306     # WORDPRESS_DB_HOST → database host (db), 3306 → MySQL default port
      WORDPRESS_DB_NAME: wordpress   # WORDPRESS_DB_NAME → database name
      WORDPRESS_DB_USER: wpuser      # ORDPRESS_DB_USER → database user
      WORDPRESS_DB_PASSWORD: wppass  # WORDPRESS_DB_PASSWORD → database password

volumes:
  db_data:                           # This defines a named Docker volume called db_data.
...

services:
  db:
    image: mysql:8.4
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wppass
      MYSQL_ROOT_PASSWORD: rootpass
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:6-php8.2-apache
    restart: unless-stopped
    depends_on:
      - db
    ports:
      - "8081:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_NAME: wordpress
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wppass

volumes:
  db_data:
```

Run it with
```bash
docker compose up -d
```
![2-container-compose](screenshots/day-33-two-container-compose.png)

Open WordPress in your browser:
```bash
http://localhost:8081
```
![wordpress-setup](screenshots/day-33-wordpress-setup.png)

![wordpress-final](screenshots/day-33-wordpress-final.png)

![down n up](screenshots/day-33-down-&-up.png)

---

## Task 4: Docker Compose Commands
### Start services in detached mode
Runs all services in the background.
```bash
docker compose up -d
```

### View running services
Shows all containers started by the compose project.
```bash
docker compose ps
```

### View logs of all services
Shows logs from every container in the compose project.
```bash
docker compose logs
```
Follow logs in real time:
```bash
docker compose logs -f
```

### View logs of a specific service
You can target a specific service.

Example: WordPress
```bash
docker compose logs wordpress
```
Example: MySQL
```bash
docker compose logs db
```
Follow logs:
```bash
docker compose logs -f wordpress
```

### Stop services without removing containers
Stops containers but keeps them created.
```bash
docker compose stop
```
Restart them:
```bash
docker compose start
```

### Remove everything (containers and networks)
Stops and removes containers, networks, and default resources.
```bash
docker compose down
```
Remove volumes as well (this deletes database data):
```bash
docker compose down -v
```

### Rebuild images after making changes
If you modify a Dockerfile or service configuration:
```bash
docker compose up -d --build
```
This will:
- rebuild images
- recreate containers
- start services again

## Quick Command Summary

| Task                                  | Command                            |
| ------------------------------------- | ---------------------------------- |
| Start services                        | `docker compose up -d`             |
| View running containers               | `docker compose ps`                |
| View logs (all services)              | `docker compose logs -f`           |
| View logs (specific service)          | `docker compose logs SERVICE_NAME` |
| Stop containers                       | `docker compose stop`              |
| Restart stopped containers            | `docker compose start`             |
| Remove containers + network           | `docker compose down`              |
| Remove containers + network + volumes | `docker compose down -v`           |
| Rebuild containers                    | `docker compose up -d --build`     |

---

## Task 5: Environment Variables
### 1. Add environment variables directly in `docker-compose.yml`
Create `docker-compose.yml`:
```YAML
---
services:
  app:
    image: nginx
    ports:
      - "8082:80"
    environment:
      APP_ENV: development
      APP_NAME: docker-compose-demo
...
start it:
```bash
docker compose up -d
```
Check variables inside the container:
```bash
docker compose exec app env
```
![Environment Variables](screenshots/day-33-Environment-Variables-1.png)

Stop it:
```bash
docker compose down
```

### 2. Use a `.env` file
Create a `.env` file:
```bash
vim .env
APP_ENV=production
APP_NAME=my-compose-project
PORT=8083
``` 

### 3. Reference .env variables in `docker-compose-dot-env.yml`
Create `docker-compose-dot-env.yml`
```YAML
---
services:
  app:
    image: nginx:latest
    ports:
      - "${PORT}:80"
    environment:
      APP_ENV: ${APP_ENV}
      APP_NAME: ${APP_NAME}
...
```
Docker Compose automatically reads `.env`.

Start it:
```bash
docker compose -f docker-compose-dot-env.yml up -d
```
Open in browser:
```bash
http://localhost:8083
```
![use .env file](screenshots/day-33-docker-compose-dot-env.png)

### 4. Verify variables are picked up
Check inside the container:
```bash
docker compose exec app env | grep APP
```
![Verify variables are picked up](screenshots/day-33-docker-compose-dot-env-output.png)
