# Docker Architecture: Client → Daemon → Registry → Image → Container

## Overview

Docker follows a client-server architecture.

Flow:

```text
Client → Daemon → Registry → Image → Container
```

## Components

### Docker Client
- Accepts user commands
- Sends requests to Docker Daemon

Examples:

```bash
docker run nginx
docker build .
docker ps
```

### Docker Daemon (dockerd)
- Background service
- Builds images
- Creates containers
- Starts and stops containers
- Manages networks and volumes

### Docker Registry
Stores Docker images.

Examples:
- Docker Hub
- Amazon ECR
- Azure ACR

### Docker Image
A read-only template used to create containers.

Contains:
- Application code
- Runtime
- Libraries
- Dependencies

### Docker Container
A running instance of an image.

## Complete Workflow

When you run:

```bash
docker run nginx
```

1. Client sends command to Daemon.
2. Daemon checks for image locally.
3. If image is missing, Daemon contacts Registry.
4. Registry provides the image.
5. Daemon creates a container from the image.
6. Container starts running.

## Visual Diagram

```text
Docker Client
      |
      v
Docker Daemon
      |
      v
Docker Registry
      |
      v
Docker Image
      |
      v
Docker Container
```

## Restaurant Analogy

| Docker Component | Analogy |
|------------------|----------|
| Client | Customer placing an order |
| Daemon | Chef preparing the order |
| Registry | Supermarket |
| Image | Recipe |
| Container | Prepared meal |

## Troubleshooting

### Cannot connect to Docker daemon
- Docker service is not running

### Unable to pull image
- No internet connection
- Registry unavailable
- Authentication issue

### Container exits immediately
- Application error
- Wrong startup command

## Why This Matters in DevOps

- Helps with troubleshooting
- Supports CI/CD pipelines
- Foundation for Kubernetes
- Improves deployment consistency

## Quick Revision Summary

| Component | Purpose |
|-----------|---------|
| Client | Sends commands |
| Daemon | Executes commands |
| Registry | Stores images |
| Image | Blueprint/template |
| Container | Running application |

### One-Line Summary

The Docker Client sends commands to the Docker Daemon, which retrieves images from a Registry if needed and creates Containers from those Images.
