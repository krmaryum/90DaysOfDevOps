# Node.js Dockerfile Explanation

This Dockerfile builds a container image for a Node.js application. Each
instruction tells Docker how to assemble the environment that will run
the app.
```YAML
# Use a small official Node.js image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package files first to take advantage of Docker layer caching
COPY package*.json ./

# Install only production dependencies for a smaller image
RUN npm install --omit=dev

# Copy the rest of the application code
COPY . .

# Create a non-root user and group for better security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Change ownership of app files to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
```
------------------------------------------------------------------------

## 1. Base Image

``` dockerfile
FROM node:20-alpine
```

-   **FROM** specifies the base image.
-   `node:20-alpine` means:
    -   Node.js version 20
    -   Alpine Linux (a very small Linux distribution)

**Benefit:** Smaller images → faster downloads and deployments.

------------------------------------------------------------------------

## 2. Set Working Directory

``` dockerfile
WORKDIR /app
```

Sets the working directory inside the container.\
All following commands run inside `/app`.

Equivalent to running:

``` bash
cd /app
```

inside the container.

------------------------------------------------------------------------

## 3. Copy Package Files First

``` dockerfile
COPY package*.json ./
```

Copies dependency files into the container.

Matches: - `package.json` - `package-lock.json`

**Why this matters:** Docker layer caching. If dependencies don't
change, Docker won't reinstall them.

------------------------------------------------------------------------

## 4. Install Dependencies

``` dockerfile
RUN npm install --omit=dev
```

Installs Node.js dependencies.

`--omit=dev` means: - Install only **production dependencies** - Skip
**devDependencies** (testing tools, linters, etc.)

Benefits: - Smaller image - Faster builds - Better security

------------------------------------------------------------------------

## 5. Copy Application Code

``` dockerfile
COPY . .
```

Copies the rest of the application code into the container.

Example files: - `server.js` - `routes/` - `controllers/` -
configuration files

------------------------------------------------------------------------

## 6. Create a Non‑Root User

``` dockerfile
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
```

Creates: - group → `appgroup` - user → `appuser`

Running containers as **non-root users** improves security.

------------------------------------------------------------------------

## 7. Change File Ownership

``` dockerfile
RUN chown -R appuser:appgroup /app
```

Changes ownership of the application files so the new user can access
them.

------------------------------------------------------------------------

## 8. Switch to Non‑Root User

``` dockerfile
USER appuser
```

After this line, everything runs as `appuser` instead of `root`.

This prevents privilege escalation attacks.

------------------------------------------------------------------------

## 9. Expose the Application Port

``` dockerfile
EXPOSE 3000
```

Indicates the container listens on port **3000**.

Example Node.js server:

``` javascript
app.listen(3000)
```

Note: This only documents the port. To access it:

``` bash
docker run -p 3000:3000 image-name
```

------------------------------------------------------------------------

## 10. Start the Application

``` dockerfile
CMD ["npm", "start"]
```

Defines the default command when the container starts.

Equivalent to:

``` bash
npm start
```

Which runs the script defined in `package.json`:

``` json
"scripts": {
  "start": "node server.js"
}
```

------------------------------------------------------------------------

# Container Startup Flow

When the container runs:

1.  Start from `node:20-alpine`
2.  Set `/app` as working directory
3.  Copy dependency files
4.  Install dependencies
5.  Copy application code
6.  Create a secure user
7.  Set proper file permissions
8.  Switch to the non-root user
9.  Expose port 3000
10. Run `npm start`

------------------------------------------------------------------------

**Result:** A small, secure, production‑ready Node.js container image.
