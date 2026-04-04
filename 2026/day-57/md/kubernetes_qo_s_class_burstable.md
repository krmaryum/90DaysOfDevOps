# Kubernetes QoS Class: Burstable

## Example Configuration

```yaml
Requests:
  cpu: 100m
  memory: 128Mi

Limits:
  cpu: 250m
  memory: 256Mi
```

---

## Why QoS Class is Burstable

- Requests and Limits are **not equal**
- Kubernetes assigns **Burstable QoS** when:
  - Requests are defined
  - Limits are higher than requests

---

## What Burstable Means

- Guaranteed minimum resources (requests)
- Can use extra resources up to limits if available

---

## Behavior

### Guaranteed Minimum
- CPU: 100m
- Memory: 128Mi

### Can Burst Higher
- CPU: up to 250m
- Memory: up to 256Mi

---

## Under Resource Pressure

If the node runs out of resources:

1. BestEffort Pods are killed first
2. Burstable Pods may be killed next
3. Guaranteed Pods are killed last

---

## OOMKilled Risk

- If memory usage exceeds 256Mi
- Container will be terminated (OOMKilled)

---

## Summary

- Burstable = flexible resource usage
- Provides minimum guarantee with room to grow
- Not as safe as Guaranteed under heavy load


---

# QoS Classes Comparison

## 1. Guaranteed

### Requirements
- Requests = Limits (for CPU and Memory)

```yaml
resources:
  requests:
    cpu: "500m"
    memory: "256Mi"
  limits:
    cpu: "500m"
    memory: "256Mi"
```

### Behavior
- Highest priority
- Not killed unless absolutely necessary
- Best for critical workloads (e.g., databases)

---

## 2. Burstable

### Requirements
- Requests defined
- Limits > Requests

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "250m"
    memory: "256Mi"
```

### Behavior
- Medium priority
- Can use extra resources if available
- May be killed under pressure before Guaranteed

---

## 3. BestEffort

### Requirements
- No requests and no limits defined

```yaml
resources: {}
```

### Behavior
- Lowest priority
- Uses resources only if available
- First to be killed under resource pressure

---

## Quick Comparison Table

| QoS Class   | Requests | Limits | Priority | Use Case |
|------------|---------|--------|----------|----------|
| Guaranteed | Equal   | Equal  | High     | Critical apps |
| Burstable  | Set     | Higher | Medium   | General apps |
| BestEffort | None    | None   | Low      | Testing / non-critical |

---

## Final Summary

- Guaranteed = safest and most stable
- Burstable = flexible and balanced
- BestEffort = least reliable but most lightweight

