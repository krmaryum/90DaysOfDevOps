# Kubernetes Deployment (php:8.2-apache) — Explanation

## Overview

This manifest defines a **Deployment** in Kubernetes that runs a PHP + Apache web server using the official `php:8.2-apache` image.

It creates and manages pods and prepares the application for scaling.

---

## Full Manifest

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  replicas: 1
  selector:
    matchLabels:
      app: php-apache
  template:
    metadata:
      labels:
        app: php-apache
    spec:
      containers:
        - name: php-apache
          image: php:8.2-apache
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: 200m
```

---

## Explanation

### apiVersion & kind

- `apiVersion: apps/v1` → Uses Kubernetes apps API
- `kind: Deployment` → Creates a Deployment resource

Deployment automatically:
- Restarts pods
- Scales pods
- Updates pods

---

### metadata

```yaml
metadata:
  name: php-apache
```

- Name of the Deployment
- Used to identify and manage the resource

---

### replicas

```yaml
replicas: 1
```

- Runs 1 pod
- Can be scaled manually or automatically

---

### selector (Important)

```yaml
selector:
  matchLabels:
    app: php-apache
```

- Matches pods with label `app=php-apache`
- Deployment manages only matching pods

---

### template (Pod Definition)

```yaml
template:
  metadata:
    labels:
      app: php-apache
```

- Labels assigned to pods
- Must match selector

---

### container configuration

```yaml
containers:
  - name: php-apache
    image: php:8.2-apache
```

- Runs official PHP + Apache image
- This is a real web server (not just a demo)

---

### ports

```yaml
ports:
  - containerPort: 80
```

- Application listens on HTTP port 80
- Not exposed outside cluster by default

---

### resources (Important for HPA)

```yaml
resources:
  requests:
    cpu: 200m
```

- Requests 200 millicores (0.2 CPU)
- Required for Horizontal Pod Autoscaler (HPA)

---

## Why CPU Request Matters

HPA calculates:

```
CPU usage % = actual usage / requested CPU
```

Example:
- Request = 200m
- Usage = 100m → 50%
- Usage = 200m → 100%

Without CPU requests, HPA will not work properly.

---

## What Happens When Applied

```bash
kubectl apply -f deployment.yaml
```

Kubernetes will:
1. Create Deployment
2. Create ReplicaSet
3. Launch Pod
4. Keep it running

---

## Architecture Flow

```
Deployment → ReplicaSet → Pod → Container (php-apache)
```

---

## Important Note

This Deployment does NOT expose the app externally.

To access it, you need a Service:

```bash
kubectl expose deployment php-apache --type=NodePort --port=80
```

---

## Summary

- Creates Deployment named `php-apache`
- Runs PHP + Apache web server
- Listens on port 80
- Requests 200m CPU (for autoscaling)
- Needs a Service for external access
