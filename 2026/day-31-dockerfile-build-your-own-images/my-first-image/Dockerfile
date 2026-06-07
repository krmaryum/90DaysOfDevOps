# Use Ubuntu as base
FROM ubuntu:latest

# Avoid interactive prompts during apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Default command prints the required message
CMD ["echo", "Hello from my custom image!"]

