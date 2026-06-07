# Use Ubuntu as base

FROM ubuntu:latest

# Avoid interactive prommpts during apt installs
# It forces package installation to run in non-interactive (automatic) mode — which is essential for reliable Docker builds.

ENV DEBIAN_FRONTEND=noninteractive

# Install curl
# Updates package metadata, Installs curl and Cleans up unnecessary cache.

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Default command prints the requried message

CMD ["echo", "Hello from my custom image!"]
