# Kubernetes `kubectl top pods -A --sort-by=cpu` — Explanation

## Command Used

```bash
kubectl top pods -A --sort-by=cpu
```

- Shows real-time CPU and memory usage of all pods
- `-A` means all namespaces
- `--sort-by=cpu` sorts pods by CPU usage (highest to lowest)

---

## Output Behavior

- Pods are listed from **highest CPU usage → lowest CPU usage**
- Helps quickly identify which components are consuming the most CPU

---

## Top CPU Consumers

### 1. kube-apiserver

```
117m   222Mi
```

- Highest CPU usage
- Handles all Kubernetes API requests (`kubectl`, controllers, etc.)
- Always one of the busiest components

---

### 2. etcd

```
75m   49Mi
```

- Kubernetes database
- Stores cluster state and configuration
- Moderate CPU usage is normal

---

### 3. kube-controller-manager

```
57m   49Mi
```

- Maintains desired state of cluster
- Recreates pods and manages controllers

---

### 4. kube-scheduler

```
27m   25Mi
```

- Decides where pods should run
- Lower usage because scheduling is not constant

---

### 5. metrics-server

```
17m   20Mi
```

- Collects resource usage metrics
- Lightweight and efficient

---

## Low Usage Components

### CoreDNS

```
5m / 4m   13Mi
```

- Handles DNS resolution inside cluster
- Low usage when traffic is low

---

### kube-proxy

```
3m   18Mi
```

- Manages service networking

---

### kindnet

```
2m   28Mi
```

- Handles pod networking in kind cluster

---

### local-path-provisioner

```
1m   8Mi
```

- Provides local storage
- Minimal usage

---

## What This Means

- API server is the top CPU consumer (expected)
- Control plane components use moderate CPU
- All other components use very low CPU
- Cluster is healthy and under low load

---

## Why This Command Is Useful

- Quickly identify CPU-heavy pods
- Debug performance issues
- Monitor cluster load
- Understand system behavior

---

## Mental Model

```
kubectl top pods            → shows usage
kubectl top pods --sort-by=cpu → shows priority (who is using most CPU)
```

---

## Pro Tip

```bash
kubectl top pods -A --sort-by=memory
```

- Shows pods sorted by memory usage instead

---

## Summary

- Pods sorted by CPU usage (highest first)
- API server is highest → normal
- No abnormal spikes detected
- Cluster is stable and efficient
