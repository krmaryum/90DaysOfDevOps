# Kubernetes Manifest — Explanation

## What is a Manifest?

In Kubernetes, a **manifest** is a YAML (or JSON) file that describes what you want Kubernetes to create.

👉 It acts like a **blueprint or instruction file** for your cluster.

---

## Simple Analogy

- Manifest = Building plan 🏗️  
- Kubernetes = Builder 👷  

You write the plan, Kubernetes builds it.

---

## Example Manifest

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: nginx
    image: nginx
```

---

## Explanation of Fields

### 1. apiVersion

- Specifies the Kubernetes API version
- Example: `v1`, `apps/v1`

---

### 2. kind

- Defines the type of resource
- Examples:
  - Pod
  - Deployment
  - Service

---

### 3. metadata

- Contains identifying information
- Includes:
  - name
  - labels
  - namespace

---

### 4. spec (Most Important)

- Defines the desired state
- Includes:
  - containers
  - images
  - ports
  - volumes
  - resources

---

## How to Use a Manifest

Apply it using:

```bash
kubectl apply -f file.yaml
```

Kubernetes reads the file and creates the resource.

---

## What Happens Internally

```
You write manifest → kubectl apply → API server → Scheduler → Pod runs
```

---

## Types of Manifests

You can create manifests for:

- Pods → run containers
- Deployments → manage replicas
- Services → expose apps
- ConfigMaps → store configuration
- Secrets → store sensitive data

---

## Key Concept (Declarative Model)

Kubernetes is declarative.

Instead of saying:
```
Run this step by step
```

You say:
```
I want this final state
```

Kubernetes ensures that state is achieved.

---

## Summary

- Manifest = YAML file describing desired state
- Used with `kubectl apply`
- Tells Kubernetes what to create
- Kubernetes handles how to create it
