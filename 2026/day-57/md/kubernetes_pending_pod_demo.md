# Kubernetes Pending Pod Demo

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pending-demo
spec:
  containers:
    - name: nginx
      image: nginx:latest
      resources:
        requests:
          cpu: "100"
          memory: "128Gi"
```

---

## What This Pod Does

- Creates a Pod with extremely high resource requests
- Used to demonstrate why Pods stay in **Pending** state

---

## Problem in Configuration

- CPU request: **100 cores**
- Memory request: **128Gi (128 GB RAM)**

Most clusters (especially local or small VMs) do not have this capacity.

---

## Result

- Kubernetes scheduler cannot find a suitable node
- Pod remains in **Pending** state indefinitely

---

## How to Verify

```bash
kubectl get pods
```

Output:

```
pending-demo   Pending
```

---

## Debugging

```bash
kubectl describe pod pending-demo
```

Typical message:

```
0/1 nodes are available: Insufficient cpu, Insufficient memory
```

---

## Why This Happens

- Scheduler checks if any node can satisfy resource requests
- No node has 100 CPUs and 128Gi memory
- Scheduling fails

---

## Fix (Realistic Values)

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
```

- 100m = 0.1 CPU
- 128Mi = small memory

Pod will now be scheduled successfully.

---

## Debugging Checklist

- Check Pod status → `kubectl get pods`
- Describe Pod → `kubectl describe pod <name>`
- Look for:
  - Insufficient CPU
  - Insufficient Memory
- Compare requests vs node capacity

---

## Summary

- Requests control scheduling
- Too high requests → Pod stays Pending
- Always match requests with cluster capacity

