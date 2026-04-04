# Kubernetes Startup Probe Demo

## YAML Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: startup-demo
spec:
  containers:
    - name: busybox
      image: busybox:1.28
      command:
        - sh
        - -c
        - sleep 20 && touch /tmp/started && sleep 600
      startupProbe:
        exec:
          command:
            - cat
            - /tmp/started
        periodSeconds: 5
        failureThreshold: 12
      livenessProbe:
        exec:
          command:
            - cat
            - /tmp/started
        periodSeconds: 5
        failureThreshold: 3
```

---

## What This Pod Does

- Demonstrates how **startup probe and liveness probe** work together
- Simulates an application that takes time to start

---

## Container Behavior

### Step-by-step:

1. Waits 20 seconds:
   ```bash
   sleep 20
   ```

2. Marks application as started:
   ```bash
   touch /tmp/started
   ```

3. Keeps running:
   ```bash
   sleep 600
   ```

---

## Startup Probe Explained

```yaml
startupProbe:
  exec:
    command:
      - cat
      - /tmp/started
```

- Runs `cat /tmp/started`
- If file exists → success
- If not → failure

---

## Startup Timing

```yaml
periodSeconds: 5
failureThreshold: 12
```

- Runs every **5 seconds**
- Allows **12 failures**

Total startup time allowed:

```
5s × 12 = 60 seconds
```

---

## Behavior

### During Startup (0–20s)
- File does not exist
- Probe fails (allowed)

### After Startup (~20s)
- File is created
- Probe succeeds
- Startup probe completes

---

## Liveness Probe Explained

```yaml
livenessProbe:
  exec:
    command:
      - cat
      - /tmp/started
```

- Starts only after startup probe succeeds
- Checks if container is still healthy

---

## Liveness Behavior

```yaml
periodSeconds: 5
failureThreshold: 3
```

- Runs every 5 seconds
- If fails 3 times → container restarts

---

## Important Concept

- Liveness probe is **disabled during startup phase**
- Prevents unnecessary restarts

---

## Why This is Important

Without startup probe:
- Liveness probe runs immediately
- App not ready yet
- Container restarts repeatedly (CrashLoopBackOff)

---

## Timeline

| Time | State |
|------|------|
| 0–20s | App starting, startup probe failing (allowed) |
| ~20s | File created, startup probe succeeds |
| After | Liveness probe begins |

---

## Summary

- Startup probe handles slow application startup
- Prevents premature restarts
- Works together with liveness probe for stability

