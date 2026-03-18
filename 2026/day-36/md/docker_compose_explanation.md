# Docker Compose File Explanation (Line by Line)

Below is a `docker-compose.yml` configuration with rewritten inline
comments explaining each line.

``` yaml
services:                                   # Defines all containers (services) that Compose will create
  app:                                      # Service name for the Node.js application
    build: .                                # Build the Docker image using the Dockerfile in the current directory
    container_name: task-manager-app        # Assign a fixed name to the running container
    ports:
      - "3000:3000"                         # Map port 3000 on the host to port 3000 inside the container
    env_file:
      - .env                                # Load environment variables from the .env file into the container
    depends_on:
      mongo:                                # Ensure the app depends on the MongoDB service
        condition: service_healthy          # Start the app only after MongoDB passes its health check
    networks:
      - task-manager-network                # Connect this container to the custom Docker network
    restart: unless-stopped                 # Automatically restart the container unless it is manually stopped

  mongo:                                    # Service name for the MongoDB database container
    image: mongo:7                          # Use the official MongoDB version 7 image from Docker Hub
    container_name: task-manager-mongo      # Assign a fixed name to the MongoDB container
    ports:
      - "27017:27017"                       # Expose MongoDB default port to the host machine
    volumes:
      - mongo_data:/data/db                 # Store database files in a persistent Docker volume
    networks:
      - task-manager-network                # Connect MongoDB container to the same custom network as the app
    healthcheck:                            # Define a health check to verify MongoDB is running properly
      test: ["CMD", "mongosh", "--eval", "db.adminCommand('ping')"]  # Run a MongoDB ping command to confirm the database is responding
      interval: 10s                         # Run the health check every 10 seconds
      timeout: 5s                           # Wait up to 5 seconds for the health check to complete
      retries: 5                            # Mark container unhealthy after 5 failed attempts
      start_period: 20s                     # Allow MongoDB 20 seconds to start before health checks begin
    restart: unless-stopped                 # Automatically restart MongoDB unless manually stopped

volumes:
  mongo_data:                               # Define a named Docker volume for storing MongoDB data persistently

networks:
  task-manager-network:                     # Define a custom network for communication between containers
    driver: bridge                          # Use the bridge network driver (default Docker network type)
```

------------------------------------------------------------------------

## How Everything Works Together

1.  Docker Compose starts the MongoDB container.
2.  MongoDB initializes and passes the health check.
3.  The Node.js application container starts.
4.  The application connects to MongoDB using:

```{=html}
<!-- -->
```
    mongodb://mongo:27017/taskdb

The hostname `mongo` works because Docker Compose allows services to
communicate using their service names.

------------------------------------------------------------------------

## Container Communication

    Host Machine
         │
         ├── localhost:3000 → Node.js Container (app)
         │
         └── localhost:27017 → MongoDB Container (mongo)

    Inside Docker Network
         │
         └── app → mongo:27017

------------------------------------------------------------------------

## Run the System

Start the containers:

    docker compose up --build

Run in detached mode:

    docker compose up -d

Stop the containers:

    docker compose down
