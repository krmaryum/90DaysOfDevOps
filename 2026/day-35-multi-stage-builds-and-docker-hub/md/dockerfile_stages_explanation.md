# Dockerfile Stages Explained

A **Dockerfile** contains instructions that Docker follows step-by-step
to build an image.\
Each instruction creates a **layer** in the image. These steps are often
referred to as *stages* in the build process.

Below is a simple example Dockerfile:

``` dockerfile
FROM node:18

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .

CMD ["node", "app.js"]
```

------------------------------------------------------------------------

# 1. Base Image Stage --- `FROM`

``` dockerfile
FROM node:18
```

**Purpose**\
Defines the **base image** that your container will start from.

The `node:18` image already includes:

-   Node.js
-   npm
-   Linux environment

So you don't need to install Node manually.

Think of it as:

> "Start building my container from a machine that already has Node.js
> installed."

------------------------------------------------------------------------

# 2. Working Directory Stage --- `WORKDIR`

``` dockerfile
WORKDIR /app
```

**Purpose**\
Sets the working directory inside the container.

All following commands will run inside this folder.

Equivalent to running:

``` bash
mkdir /app
cd /app
```

inside the container.

------------------------------------------------------------------------

# 3. Dependency Copy Stage --- `COPY package.json`

``` dockerfile
COPY package.json .
```

**Purpose**\
Copies the `package.json` file from your host machine into the
container.

Example:

Host machine:

    day-35/task-1/package.json

Container:

    /app/package.json

This step is separated to improve **Docker caching**.

------------------------------------------------------------------------

# 4. Install Dependencies Stage --- `RUN`

``` dockerfile
RUN npm install
```

**Purpose**\
Executes a command inside the container during the **image build
process**.

It installs dependencies listed in `package.json`.

Example:

``` json
"dependencies": {
  "express": "^4.18.2"
}
```

Docker will create:

    node_modules/

inside the container.

Important:

-   `RUN` executes during **build time**
-   Not when the container runs

------------------------------------------------------------------------

# 5. Copy Application Code --- `COPY . .`

``` dockerfile
COPY . .
```

**Purpose**\
Copies all remaining project files into the container.

Example files:

    app.js
    package.json
    Dockerfile

Destination:

    /app/

------------------------------------------------------------------------

# 6. Container Start Command --- `CMD`

``` dockerfile
CMD ["node", "app.js"]
```

**Purpose**\
Defines the default command executed when the container starts.

When you run:

``` bash
docker run day35-single-stage
```

Docker runs:

``` bash
node app.js
```

------------------------------------------------------------------------

# Build Time vs Run Time

  Instruction   Runs When
  ------------- -------------------
  FROM          Build time
  WORKDIR       Build time
  COPY          Build time
  RUN           Build time
  CMD           Container runtime

------------------------------------------------------------------------

# Docker Build Flow

    Start build
       │
       ▼
    FROM node:18
       │
       ▼
    WORKDIR /app
       │
       ▼
    COPY package.json
       │
       ▼
    RUN npm install
       │
       ▼
    COPY project files
       │
       ▼
    Image created
       │
       ▼
    docker run
       │
       ▼
    CMD ["node","app.js"]

------------------------------------------------------------------------

# Multi‑Stage Builds

Sometimes a Dockerfile contains multiple `FROM` instructions.

Example:

``` dockerfile
FROM node:18 AS builder
RUN npm install

FROM node:18-slim
COPY --from=builder /app /app
```

This creates multiple stages:

-   **Build stage**
-   **Production stage**

Benefits:

-   Smaller image size
-   Better security
-   Faster deployments

------------------------------------------------------------------------

# Summary

Dockerfile stages are the sequential instructions that Docker follows to
build and run a container image.

Common instructions include:

-   `FROM`
-   `WORKDIR`
-   `COPY`
-   `RUN`
-   `CMD`

Understanding these stages helps you build efficient, reproducible
container images.

---

## Visual Comparison
### Single Stage
```text
Base Image
   │
   ▼
Install dependencies
   │
   ▼
Copy source code
   │
   ▼
Run app
   │
   ▼
Final Image (large)
```

### Multi Stage
```text
Stage 1 (Builder)
Base Image
   │
Install dependencies
   │
Build application
   │
   ▼
Stage 2 (Runtime)
Small base image
   │
Copy built files
   │
Run app
   │
   ▼
Final Image (small)
```

## Key Differences

| Feature          | Single Stage | Multi Stage   |
| ---------------- | ------------ | ------------- |
| `FROM` count     | One          | Multiple      |
| Complexity       | Simple       | More advanced |
| Image size       | Larger       | Smaller       |
| Security         | Lower        | Higher        |
| Production usage | Rare         | Recommended   |

## When to Use Each
### Use Single-Stage when
- Learning Docker
- Small scripts
- Simple Node apps
- Quick testing
Example:
```text
node script.js
```
### Use Multi-Stage when
- Building production apps
- Compiling code
- Using build tools
- Reducing image size
- CI/CD pipelines

Examples:
- React
- Go
- Java
-Python builds
- Microservices

## Simple rule
```text
Single Stage  → Simple projects
Multi Stage   → Production applications
```
