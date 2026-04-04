# Kubernetes Probes Overview

## What is a Probe?

A **probe** is a health check mechanism used by Kubernetes to monitor containers.

It helps answer:
- Is the container alive?
- Is it ready to serve traffic?
- Has it started properly?

---

## Why Probes are Important

- Detect unhealthy applications
- Automatically restart failed containers
- Prevent traffic from reaching unready Pods
- Improve reliability and self-healing

---

## Types of Probes

### 1. Liveness Probe

- Checks if the container is still running correctly
- If it fails → container is restarted

**Use case:**
- Detect stuck or deadlocked applications

---

### 2. Readiness Probe

- Checks if the container is ready to accept traffic
- If it fails → Pod is removed from Service endpoints
- Does NOT restart the container

**Use case:**
- App initialization
- Waiting for dependencies (e.g., database)

---

### 3. Startup Probe

- Checks if the application has started successfully
- Disables liveness/readiness until startup is complete

**Use case:**
- Slow-starting applications

---

## Probe Types (How Checks Are Performed)

### HTTP Probe

```yaml
httpGet:
  path: /
  port: 80
```

### Exec Probe

```yaml
exec:
  command: ["cat", "/tmp/healthy"]
```

### TCP Probe

```yaml
tcpSocket:
  port: 80
```

---

## Common Configuration Options

- `periodSeconds` → how often to run the probe
- `failureThreshold` → number of failures before action
- `initialDelaySeconds` → delay before first check

---

## Behavior Summary

| Scenario | Kubernetes Action |
|----------|------------------|
| App crashes | Restart container (liveness) |
| App not ready | Remove from service (readiness) |
| App starting slowly | Wait (startup probe) |

---

## Simple Analogy

Think of a restaurant:

- **Liveness** → Is the chef alive?
- **Readiness** → Is the kitchen ready to take orders?
- **Startup** → Has the kitchen finished setup?

---

## Summary

- Probes are essential for container health monitoring
- Enable automatic recovery and traffic control
- Improve application reliability in Kubernetes

