# Multi-Stage Dockerfile Explanation

This document explains a **multi-stage Dockerfile** used to build and
run a simple Node.js application.

## Dockerfile

``` dockerfile
# Stage 1: Build stage
FROM node:18 AS builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY app.js .

# Stage 2: Runtime stage
FROM node:18-alpine

WORKDIR /app

COPY --from=builder /app/app.js .
COPY --from=builder /app/package.json .

CMD ["node", "app.js"]
```

------------------------------------------------------------------------

# What is a Multi-Stage Build?

A **multi-stage build** uses multiple `FROM` instructions in a
Dockerfile.

Each `FROM` creates a new build stage.\
You can copy files from one stage to another, allowing you to keep the
final image **small and clean**.

Benefits:

-   Smaller final image
-   Better security
-   Removes unnecessary build tools
-   Faster deployment

------------------------------------------------------------------------

# Stage 1: Build Stage

    FROM node:18 AS builder

This starts the **first build stage**.

-   Uses the base image `node:18`
-   The stage is named **builder**

Naming the stage allows us to copy files from it later:

    COPY --from=builder

The builder stage is temporary and is **not included in the final
image**.

------------------------------------------------------------------------

    WORKDIR /app

Sets the working directory inside the container.

Equivalent to:

    mkdir /app
    cd /app

All following commands run inside `/app`.

------------------------------------------------------------------------

    COPY package.json .

Copies the `package.json` file from the host machine into the container.

Host:

    project/package.json

Container:

    /app/package.json

------------------------------------------------------------------------

    RUN npm install

Runs a command during **image build time**.

This installs dependencies defined in `package.json`.

Result inside container:

    /app/node_modules

------------------------------------------------------------------------

    COPY app.js .

Copies the application source code into the container.

Builder stage now contains:

    /app
     ├── package.json
     ├── node_modules
     └── app.js

------------------------------------------------------------------------

# Stage 2: Runtime Stage

    FROM node:18-alpine

This begins the **runtime stage**, which becomes the final image.

Smaller base image comparison:

  Image            Size
  ---------------- ---------
  node:18          \~350MB
  node:18-alpine   \~60MB

------------------------------------------------------------------------

    WORKDIR /app

Creates and switches to `/app` in the runtime container.

------------------------------------------------------------------------

    COPY --from=builder /app/app.js .

Copies `app.js` from the builder stage.

Syntax:

    COPY --from=<stage-name> <source> <destination>

------------------------------------------------------------------------

    COPY --from=builder /app/package.json .

Copies `package.json` from the builder stage.

Runtime container now contains:

    /app
     ├── app.js
     └── package.json

------------------------------------------------------------------------

    CMD ["node", "app.js"]

Defines the command executed when the container starts.

Running:

    docker run day35-multi-stage

Executes:

    node app.js

Output:

    Hello from Docker Day 35!

------------------------------------------------------------------------

# Build Flow

    Stage 1 (Builder)
    -----------------
    node:18
       |
    install dependencies
    copy source code
    prepare app

    Stage 2 (Runtime)
    -----------------
    node:18-alpine
       |
    copy required files from builder
       |
    run node app.js

------------------------------------------------------------------------

# Why Multi-Stage Images Are Smaller

Single-stage build:

-   build tools included
-   dependencies included
-   intermediate layers remain

Multi-stage build:

1.  Build app in temporary stage
2.  Copy only necessary files to runtime stage

Result:

-   smaller image
-   faster deployment
-   cleaner container

------------------------------------------------------------------------

# Summary

Single-stage build:

-   One `FROM`
-   Everything stays in final image

Multi-stage build:

-   Multiple `FROM`
-   Separate build and runtime environments
-   Only required files remain in final image
