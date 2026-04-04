# Kubernetes OOMKilled Demo (oom-demo Pod)

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: oom-demo
spec:
  containers:
    - name: stress
      image: polinux/stress
      resources:
        limits:
          memory: "100Mi"
      command: ["stress"]
      args: ["--vm", "1", "--vm-bytes", "200M", "--vm-hang", "1"]
```

---

## What This Pod Does

- This Pod is intentionally designed to trigger an **OOMKilled** error
- It simulates a container that uses more memory than allowed

---

## Key Components

### Container Image
- `polinux/stress`
- Used to generate CPU and memory load for testing

### Memory Limit
- Limit set to: **100Mi**
- Container cannot use more than this

---

## Stress Command Explanation

- `--vm 1` → Start 1 worker process
- `--vm-bytes 200M` → Allocate 200MB memory
- `--vm-hang 1` → Hold the allocated memory

---

## What Happens Step-by-Step

1. Container starts successfully
2. Stress tool tries to allocate **200MB memory**
3. Memory limit is only **100Mi**
4. Memory usage exceeds the limit
5. Kubernetes kills the container

---

## Result

- Pod enters **CrashLoopBackOff** state
- Container status shows **OOMKilled**

---

## How to Verify

```bash
kubectl describe pod oom-demo
```

Look for:

```
Reason: OOMKilled
```

---

## Summary

- Memory limit = 100Mi
- Application tries = 200M
- Result = Container terminated (OOMKilled)

---

## Purpose of This Demo

- Understand how memory limits work
- Observe OOMKilled behavior
- Learn importance of proper resource configuration

