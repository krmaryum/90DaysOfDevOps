# Base image
FROM python:3.11-slim

# Run commands during build
RUN apt-get update && apt-get install -y curl

# Set working directory
WORKDIR /app

# Copy files from host to container
COPY . /app

# Document the port used by the container
EXPOSE 8000

# Default command when container starts
CMD ["python", "-m", "http.server", "8000"]
