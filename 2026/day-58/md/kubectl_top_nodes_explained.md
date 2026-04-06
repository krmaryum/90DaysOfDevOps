# Kubernetes Metrics Server Output — Explanation

## Command Used

```bash
kubectl top nodes
```

This command shows real-time CPU and memory usage of nodes using Metrics Server.

---

## Output

```
NAME                           CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)
devops-cluster-control-plane   391m         3%       1037Mi          13%
```

---

## Column Explanation

### 1. NAME

```
devops-cluster-control-plane
```

- This is the name of the node
- In a kind cluster, this is usually the control-plane node
- It runs core Kubernetes components and workloads

---

### 2. CPU(cores)

```
391m
```

- CPU is measured in millicores
- 1000m = 1 CPU core
- 391m = 0.391 CPU

👉 The node is using about 0.39 of a CPU core

---

### 3. CPU(%)

```
3%
```

- Percentage of total CPU capacity being used
- 3% means very low usage

---

### 4. MEMORY(bytes)

```
1037Mi
```

- Memory usage in Mebibytes (Mi)
- Approximately 1 GB of RAM is being used

---

### 5. MEMORY(%)

```
13%
```

- Percentage of total memory being used
- 13% indicates low memory usage

---

## What This Means

- The cluster is lightly loaded
- CPU and memory usage are low
- System is healthy and stable

---

## Why This Confirms Metrics Server Works

- You are successfully getting live metrics
- This means Metrics Server is properly configured
- The TLS fix (if applied) is working correctly

---

## Next Step

Try:

```bash
kubectl top pods
```

This will show resource usage for individual pods.

---

## Summary

- 391m CPU → ~0.39 core usage
- 3% CPU → very low load
- 1037Mi memory → ~1GB usage
- 13% memory → low usage

Your Kubernetes cluster is running efficiently.
