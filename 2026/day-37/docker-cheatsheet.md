# Day 37 – Docker Revision & Cheat Sheet
## Docker Cheat Sheet

## Container Commands
docker run -it ubuntu bash        # Run container interactively
docker run -d nginx               # Run container in background
docker ps                         # List running containers
docker ps -a                      # List all containers
docker stop <id>                  # Stop container
docker start <id>                 # Start container
docker rm <id>                    # Remove container
docker exec -it <id> bash         # Exec into container
docker logs <id>                  # View logs

---

## Image Commands
docker build -t app:v1 .          # Build image
docker images                     # List images
docker pull nginx                 # Pull image from Docker Hub
docker push username/app:v1       # Push image to Docker Hub
docker rmi <id>                   # Remove image
docker tag app:v1 username/app:v1 # Tag image

---

## Volume Commands
docker volume create my-vol       # Create volume
docker volume ls                  # List volumes
docker volume inspect my-vol      # Inspect volume
docker volume rm my-vol           # Remove volume

---

## Network Commands
docker network create app-net     # Create network
docker network ls                 # List networks
docker network inspect app-net    # Inspect network
docker network connect app-net c1 # Connect container to network

---

## Docker Compose
docker compose up -d              # Start services
docker compose down               # Stop services
docker compose ps                 # List services
docker compose logs               # View logs
docker compose build              # Build services

---

## Cleanup Commands
docker system df                  # Show disk usage
docker system prune               # Remove unused data
docker volume prune               # Remove unused volumes
docker image prune                # Remove unused images

---

## Dockerfile Instructions
FROM node:18-alpine              # Base image
WORKDIR /app                     # Set working directory
COPY . .                         # Copy files
RUN npm install                  # Install dependencies
EXPOSE 3000                      # Expose port
CMD ["node", "index.js"]         # Default command
ENTRYPOINT ["node"]              # Fixed executable

---

## Common Flags
-d       # Detached mode
-it      # Interactive terminal
-p       # Port mapping (host:container)
-v       # Volume mount
--name   # Assign container name
--env    # Set environment variable

---


