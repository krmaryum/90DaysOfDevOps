# Day 31 – Dockerfile: Build Your Own Images

---

## Task 1 – Your First Dockerfile

### Build Image
docker build -t my-ubuntu:v1 .

Builds the Ubuntu-based image and tags it as `my-ubuntu:v1`.

### Run Container
docker run --rm my-ubuntu:v1

Runs the container and removes it after execution.

---

## Task 2 – Dockerfile Instructions (Node App)

### Build Image
docker build -t docker-task2:v1 .

Builds the Node.js application image.

### Run Container
docker run -p 3000:3000 docker-task2:v1

Runs the container and maps port 3000 from container to host.

---

## Task 3 – CMD vs ENTRYPOINT

### CMD Image

docker build -f Dockerfile.cmd -t cmd-image:v1 .

Builds the CMD-based image.

docker run --rm cmd-image:v1

Runs container using default CMD.

docker run --rm cmd-image:v1 echo bhai

Overrides the default CMD completely.

---

### ENTRYPOINT Image

docker build -f Dockerfile.entrypoint -t entrypoint-image:v1 .

Builds the ENTRYPOINT-based image.

docker run --rm entrypoint-image:v1

Runs ENTRYPOINT without arguments.

docker run --rm entrypoint-image:v1 hello

Appends argument to ENTRYPOINT command.

---

## Task 4 – Static Website with Nginx

### Build Image
docker build -t my-website:v1 .

Builds the Nginx-based website image.

### Run Container
docker run -p 8080:80 my-website:v1

Runs the container and maps port 8080 (host) to port 80 (container).

Access in browser:
http://localhost:8080

---

## Task 5 – .dockerignore

### Create Ignore File
touch .dockerignore

Creates a `.dockerignore` file.

### Build Image
docker build -t docker-task2:v2 .

Builds the image while excluding ignored files from build context.

### Verify Inside Container
docker run --rm -it docker-task2:v2 sh

Opens interactive shell to confirm ignored files are not included.

---

## Task 6 – Build Optimization & Cache

### Initial Build
docker build -t cache-test:v1 .

Builds the image and creates cache layers.

### Rebuild to See Cache Usage
docker build --progress=plain -t cache-test:v1 .

Rebuilds and shows which layers are cached.

### Force Full Rebuild
docker build --no-cache -t cache-test:v1 .

Forces Docker to rebuild all layers without using cache.

---

## Core Concept

Docker builds images in layers.

If one layer changes, all layers after it must rebuild.

Therefore, frequently changing instructions (like copying source code) should be placed at the bottom of the Dockerfile to improve build speed.