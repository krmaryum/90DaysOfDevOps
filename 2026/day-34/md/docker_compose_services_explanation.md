# Docker Compose File Explanation

This document explains the following Docker Compose configuration and
describes each line.

------------------------------------------------------------------------

## Docker Compose Configuration

``` yaml
services:
  web:
    build: ./app
    ports:
      - 5000:5000
    environment:
      DB_HOST: db
      REDIS_HOST: redis
  db:
    image: postgres:15
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: appdb
  redis:
    image: redis:7
```

------------------------------------------------------------------------

# Overview

This Docker Compose file defines **three services** that work together:

-   **web** → Flask application
-   **db** → PostgreSQL database
-   **redis** → Redis cache server

Docker Compose will create containers for all three services and connect
them on the same network so they can communicate using service names.

------------------------------------------------------------------------

# Line‑by‑Line Explanation

## services

    services:

This begins the **services section** of the Docker Compose file.

Every container that should run as part of the application is defined
inside this section.

------------------------------------------------------------------------

## web service

    web:

Defines a service named **web**.

This service represents the **Flask web application container**.

Other containers can reach it using the hostname `web`.

------------------------------------------------------------------------

    build: ./app

This tells Docker to **build an image from the `./app` directory**.

Docker will:

1.  Enter the `app` directory
2.  Read the `Dockerfile`
3.  Build the container image for the web application

------------------------------------------------------------------------

    ports:

This section defines **port mappings** between the host machine and the
container.

------------------------------------------------------------------------

    - 5000:5000

This maps:

Host port → `5000`\
Container port → `5000`

This means the Flask application will be accessible at:

    http://localhost:5000

------------------------------------------------------------------------

    environment:

This section defines **environment variables** that will be available
inside the container.

Environment variables allow configuration without modifying the code.

------------------------------------------------------------------------

    DB_HOST: db

This sets the environment variable `DB_HOST` to `db`.

The Flask application uses this value to connect to the **PostgreSQL
database container**.

------------------------------------------------------------------------

    REDIS_HOST: redis

This sets the environment variable `REDIS_HOST` to `redis`.

The Flask application uses this hostname to connect to the **Redis
container**.

------------------------------------------------------------------------

## db service

    db:

Defines a service named **db**.

This service runs the PostgreSQL database container.

Other services can connect to it using hostname:

    db

------------------------------------------------------------------------

    image: postgres:15

This tells Docker to use the **official PostgreSQL image version 15**
from Docker Hub.

If the image is not available locally, Docker will download it
automatically.

------------------------------------------------------------------------

    environment:

Defines environment variables required to initialize PostgreSQL.

------------------------------------------------------------------------

    POSTGRES_USER: postgres

Creates the default PostgreSQL user named:

    postgres

------------------------------------------------------------------------

    POSTGRES_PASSWORD: postgres

Sets the password for the PostgreSQL user.

This is acceptable for development but **should not be used in
production**.

------------------------------------------------------------------------

    POSTGRES_DB: appdb

Creates a database named:

    appdb

when the PostgreSQL container starts.

------------------------------------------------------------------------

## redis service

    redis:

Defines a service named **redis**.

This container runs the Redis server used for caching.

Other containers can connect to Redis using hostname:

    redis

------------------------------------------------------------------------

    image: redis:7

This uses the **official Redis image version 7**.

Docker will pull the image from Docker Hub if it is not already
installed locally.

------------------------------------------------------------------------

# How the Services Communicate

Docker Compose automatically creates a **shared network**.

This allows containers to communicate using their service names:

  Service   Connects To   Hostname Used
  --------- ------------- ---------------
  web       PostgreSQL    db
  web       Redis         redis

------------------------------------------------------------------------

# Architecture Diagram

            Browser
               │
               ▼
          Flask Web App
               │
        ┌──────┴──────┐
        ▼             ▼
    PostgreSQL      Redis
       (db)         (redis)

------------------------------------------------------------------------

# Key Idea

Docker Compose allows multiple services to be defined in a single file
and started together with one command:

    docker compose up
