# Kubernetes HPA (autoscaling/v2) — Detailed Explanation

## Overview

This manifest defines a **Horizontal Pod Autoscaler (HPA)** using the advanced `autoscaling/v2` API.

It automatically scales the `php-apache` Deployment based on CPU usage and includes custom scaling behavior.

---

## Full Manifest

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
```

---

## Explanation

### apiVersion & kind

- `apiVersion: autoscaling/v2` → Advanced HPA API
- `kind: HorizontalPodAutoscaler` → Creates an autoscaler

---

### metadata

```yaml
metadata:
  name: php-apache
```

- Name of the HPA resource

---

### scaleTargetRef (Important)

```yaml
scaleTargetRef:
  apiVersion: apps/v1
  kind: Deployment
  name: php-apache
```

- Defines which resource to scale
- Targets the `php-apache` Deployment

---

### minReplicas & maxReplicas

```yaml
minReplicas: 1
maxReplicas: 10
```

- Minimum pods = 1
- Maximum pods = 10

---

### metrics (Scaling Criteria)

```yaml
metrics:
  - type: Resource
    resource:
      name: cpu
```

- Uses CPU as the scaling metric

---

### target

```yaml
target:
  type: Utilization
  averageUtilization: 50
```

- Target CPU usage = 50% of requested CPU

Example:
- CPU request = 200m
- 100m usage = 50%
- 200m usage = 100%

---

## behavior (Advanced Feature)

This controls how fast scaling happens.

---

### scaleUp

```yaml
scaleUp:
  stabilizationWindowSeconds: 0
```

- No delay when scaling up
- Reacts immediately to increased load

---

#### scaleUp policies

```yaml
- type: Percent
  value: 100
  periodSeconds: 15
```

- Can double the number of pods every 15 seconds

Example:
- 1 → 2 → 4 → 8 pods

---

### scaleDown

```yaml
scaleDown:
  stabilizationWindowSeconds: 300
```

- Waits 5 minutes before scaling down
- Prevents rapid fluctuations

---

#### scaleDown policies

```yaml
- type: Percent
  value: 100
  periodSeconds: 15
```

- Can reduce pods quickly, but only after delay

---

## Why Behavior Matters

- Prevents unstable scaling (thrashing)
- Allows fast response to traffic spikes
- Ensures smooth and stable scaling down

---

## Real-world Flow

```
Traffic increases → CPU rises → HPA scales up immediately
Traffic drops → HPA waits 5 minutes → then scales down
```

---

## Comparison

| Basic HPA (CLI) | Advanced HPA (YAML v2) |
|----------------|------------------------|
| Simple scaling | Fine-grained control |
| No behavior tuning | Custom scaling speed |
| Quick setup | Production-ready |

---

## Summary

- Scales `php-apache` Deployment
- Maintains CPU at ~50%
- Range: 1 to 10 pods
- Fast scale up (no delay)
- Slow scale down (5 min delay)
- Uses advanced HPA v2 features
