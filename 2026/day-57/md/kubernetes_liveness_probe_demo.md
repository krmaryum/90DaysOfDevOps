# Kubernetes Liveness Probe Demo

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: liveness-demo
spec:
  containers:
    - name: busybox
      image: busybox:1.28
      command:
        - sh
        - -c
        - touch /tmp/healthy; sleep 30; rm -f /tmp/healthy; sleep 600
      livenessProbe:
        exec:
          command:
            - cat
            - /tmp/healthy
        periodSeconds: 5
        failureThreshold: 3
```

---

## What This Pod Does

- Demonstrates how **liveness probes** work
- Simulates an application that becomes unhealthy after some time

---

## Container Behavior

### Step-by-step:

1. Creates a file:
   ```bash
   touch /tmp/healthy
   ```
   → Container is healthy

2. Waits 30 seconds:
   ```bash
   sleep 30
   ```

3. Deletes the file:
   ```bash
   rm -f /tmp/healthy
   ```
   → Container becomes unhealthy

4. Continues running:
   ```bash
   sleep 600
   ```

---

## Liveness Probe Explained

```yaml
livenessProbe:
  exec:
    command:
      - cat
      - /tmp/healthy
```

- Runs `cat /tmp/healthy`
- If file exists → success (healthy)
- If file is missing → failure (unhealthy)

---

## Probe Configuration

```yaml
periodSeconds: 5
failureThreshold: 3
```

- Runs every **5 seconds**
- After **3 consecutive failures**, container is restarted

---

## What Happens in This Demo

### First 30 seconds
- File exists
- Probe succeeds

### After 30 seconds
- File deleted
- Probe starts failing

Timeline:
- 1st failure → 5s
- 2nd failure → 10s
- 3rd failure → 15s

→ Container is restarted

---

## Result

- Container enters restart loop
- Restart count increases

---

## How to Verify

```bash
kubectl get pod liveness-demo
```

```bash
kubectl describe pod liveness-demo
```

Look for:

```
Liveness probe failed
Killing container
```

---

## Summary

- Liveness probe checks if container is still alive
- If probe fails repeatedly → Kubernetes restarts container
- Enables self-healing behavior in applications

