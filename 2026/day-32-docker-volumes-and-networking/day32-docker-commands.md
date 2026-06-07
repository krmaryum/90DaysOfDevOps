# Docker Commands Used in Day 32 -- Volumes & Networking

  -----------------------------------------------------------------------
  Command                     Explanation
  --------------------------- -------------------------------------------
  docker run                  Creates and starts a new container from an
                              image.

  docker run -d               Runs a container in detached (background)
                              mode.

  docker ps                   Lists all currently running containers.

  docker stop                 Stops a running container.

  docker rm                   Removes a stopped container.

  docker exec -it             Runs a command inside a running container
                              interactively.

  docker volume create        Creates a named Docker volume for
                              persistent data.

  docker volume ls            Lists all Docker volumes on the system.

  docker volume inspect       Shows detailed information about a Docker
                              volume.

  docker network create       Creates a custom Docker network.

  docker network ls           Lists all Docker networks.

  docker network inspect      Displays detailed configuration of a Docker
                              network.

  docker exec container ping  Tests connectivity between containers by
  container                   name.

  docker run -v volume:/path  Attaches a named volume to a container.

  docker run -v               Mounts a host directory into the container
  host_path:container_path    (bind mount).

  docker run --network        Runs a container attached to a specific
  network_name                Docker network.

  docker pull                 Downloads an image from Docker Hub if it is
                              not available locally.
  -----------------------------------------------------------------------
