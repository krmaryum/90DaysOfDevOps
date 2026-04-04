# Kubernetes Resources and Probes

## Resource Requests and Limits

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp
spec:
  containers:
    - name: myapp-container
      image: nginx
      resources:
        requests:
          cpu: "200m"
          memory: "128Mi"
        limits:
          cpu: "500m"
          memory: "256Mi"
```

### Explanation

- **Requests**: Minimum resources required by the container
- **Limits**: Maximum resources the container can use

### Behavior

- Scheduler uses requests to place Pods on nodes
- Exceeding memory limit → Pod may be **OOMKilled**
- Exceeding CPU limit → CPU is throttled (not killed)

---

## Deployment Example

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
        - name: myapp-container
          image: nginx
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "250m"
              memory: "128Mi"
            limits:
              cpu: "500m"
              memory: "256Mi"
```

---

## Kubernetes Probes

### Liveness Probe
- Checks if container is alive
- Restarts container if it fails

### Readiness Probe
- Checks if container is ready to serve traffic
- Removes Pod from service if not ready

### Startup Probe
- Ensures app has started before other probes run
- Useful for slow-starting applications

---

## OOMKilled

- Stands for **Out Of Memory Killed**
- Happens when container exceeds memory limit
- Kubernetes kills the container to protect the node

---

## Useful Commands

```bash
kubectl top pod
kubectl describe pod <pod-name>
```

---

## Summary

- Containers are lightweight but depend on the app inside
- Requests = minimum guaranteed resources
- Limits = maximum allowed resources
- Probes = health checks (alive, ready, started)
- OOMKilled = container used too much memory and was terminated

