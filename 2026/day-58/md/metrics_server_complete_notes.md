# Kubernetes Metrics Server — Complete Notes

## Overview

This document explains the Kubernetes Metrics Server, its deployment YAML, and important fixes (especially for kind clusters).

---

# 🔹 Metrics Server Basics

The Metrics Server collects real-time CPU and memory usage from nodes and pods.

It enables:
- `kubectl top`
- Horizontal Pod Autoscaler (HPA)

---

# 🔹 YAML Components Explained

## 1. ServiceAccount

- Identity for Metrics Server
- Runs in `kube-system`

---

## 2. RBAC

### aggregated-metrics-reader
- Read metrics from pods and nodes

### system:metrics-server
- Access Kubelet metrics (`nodes/metrics`)

### Bindings
- Connect permissions to Metrics Server

---

## 3. Service

- Exposes Metrics Server internally
- Uses HTTPS (port 443)

---

## 4. Deployment

Runs container:

```
registry.k8s.io/metrics-server/metrics-server:v0.8.1
```

### Important flags

```
--secure-port=10250
--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname
--metric-resolution=15s
```

---

### Health checks

- `/livez`
- `/readyz`

---

### Security

- Non-root user
- Read-only filesystem

---

## 5. APIService

Registers:

```
metrics.k8s.io
```

Enables:
- kubectl top
- autoscaling

---

# 🔹 Architecture Flow

```
Kubelet → Metrics Server → Service → API → kubectl / HPA
```

---

# 🔹 IMPORTANT FIX (for kind / local clusters)

## ❗ Problem

Metrics Server fails with TLS errors:

```
x509: certificate signed by unknown authority
```

---

## 🔧 Step 3 — Fix

Run:

```
kubectl edit deployment metrics-server -n kube-system
```

Find:

```
args:
```

Add:

```
- --kubelet-insecure-tls
```

---

## 🧠 What this does

- Disables TLS certificate verification
- Allows Metrics Server to talk to Kubelet even with invalid certs

---

## ⚠️ Warning

✔ OK for:
- kind
- Minikube
- local testing

❌ NOT for:
- production clusters

---

## 🔄 Step 4 — Wait for rollout

Run:

```
kubectl rollout status deployment metrics-server -n kube-system
```

---

## ✅ Expected result

```
deployment "metrics-server" successfully rolled out
```

---

## 🎯 Verify

```
kubectl top nodes
kubectl top pods
```

You should now see metrics.

---

# 🔹 Final Summary

- Metrics Server provides real-time resource usage
- YAML sets up deployment, permissions, and API
- Local clusters need TLS workaround
- Rollout applies the fix
