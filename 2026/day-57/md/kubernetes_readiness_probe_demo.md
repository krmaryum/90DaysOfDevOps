# Kubernetes Readiness Probe Demo

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: readiness-demo
  labels:
    app: readiness-demo
spec:
  containers:
    - name: nginx
      image: nginx:latest
      readinessProbe:
        httpGet:
          path: /
          port: 80
        periodSeconds: 5
        failureThreshold: 3
```

---

## What This Pod Does

- Demonstrates how **readiness probes** work
- Ensures traffic is only sent to a healthy and ready container

---

## Container Details

- Image: `nginx:latest`
- Runs a web server on port **80**

---

## Readiness Probe Explained

```yaml
readinessProbe:
  httpGet:
    path: /
    port: 80
```

- Kubernetes sends an HTTP request:
  ```
  GET http://<pod-ip>:80/
  ```
- If response is successful (200 OK) → Pod is **Ready**
- If request fails → Pod is **Not Ready**

---

## Probe Configuration

```yaml
periodSeconds: 5
failureThreshold: 3
```

- Runs every **5 seconds**
- After **3 consecutive failures**, Pod is marked **Not Ready**

---

## Behavior

### When Healthy
- NGINX responds successfully
- Pod status: **Ready = True**
- Receives traffic from Services

### When Not Ready
- HTTP request fails
- Pod status: **Ready = False**
- Removed from Service endpoints

---

## Important Note

- Readiness probe does **NOT restart** the container
- It only controls whether the Pod receives traffic

---

## Difference from Liveness Probe

| Feature | Readiness Probe | Liveness Probe |
|--------|----------------|----------------|
| Purpose | Ready for traffic | Container health |
| Action on failure | Remove from service | Restart container |
| Restart | No | Yes |

---

## How to Verify

```bash
kubectl get pod readiness-demo
```

```bash
kubectl describe pod readiness-demo
```

---

## Summary

- Readiness probe controls traffic routing
- Ensures only ready Pods serve requests
- Prevents failures during startup or downtime

