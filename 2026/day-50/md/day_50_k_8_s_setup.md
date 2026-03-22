# Day 50 — Kubernetes Setup & Notes

## 📘 Introduction
You have been building and shipping containers with Docker. But when you need to run hundreds of containers across multiple servers, you need an orchestrator.

👉 Kubernetes is that orchestrator.

---

## 🧠 Core Concept: Desired State
> You describe the desired state, Kubernetes makes it happen.

- You define what you want (e.g., 3 pods)
- Kubernetes ensures it always stays that way

---

## 📦 Page 2 — What is Kubernetes?
- Open-source container orchestration tool
- Automates deployment, scaling, and load balancing
- Works on cloud, VM, or physical machines
- Also known as **K8s**

### Features:
- Orchestration
- Auto-scaling
- Auto-healing
- Load balancing
- Fault tolerance

---

## 🏗️ Page 3–4 — Architecture
### Two Main Components:

#### 1. Control Plane (Master)
- API Server → entry point
- Scheduler → assigns pods to nodes
- Controller Manager → maintains desired state
- etcd → stores cluster data

#### 2. Worker Nodes
- Run actual workloads (pods)

### Flow:
```
kubectl → API Server → Control Plane → Nodes → Pods
```

---

## ⚙️ Page 5–6 — Components

### etcd
- Key-value store
- Stores cluster state

### Scheduler
- Assigns pods to nodes

### Controller Manager
- Ensures actual state = desired state

### Node Components:
- Kubelet → communicates with control plane
- Container Runtime → runs containers
- Kube-proxy → networking

---

## 📦 Page 7–9 — Pods
- Smallest unit in Kubernetes
- Contains one or more containers
- Each pod gets a unique IP

### Key Points:
- Kubernetes works with Pods, not containers
- Pods are temporary (created/destroyed)
- Usually one container per pod

---

## 📄 Page 8 — YAML Manifest
Every manifest includes:
1. apiVersion
2. kind
3. metadata
4. spec

### Example:
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: apache-pod
spec:
  containers:
  - name: apache-container
    image: httpd
```

---

## 🔁 Page 10–12 — Services & Deployments

### Service:
- Provides stable IP
- Load balances traffic

### Deployment:
- Manages pods
- Handles updates & rollback

---

## 🌐 Page 13 — Service Types
- ClusterIP → internal
- NodePort → external via node
- LoadBalancer → cloud-based

---

## 🌍 Page 14 — Ingress
- Allows external access to services
- Uses routing rules

---

## 🧩 Page 15 — Kubernetes Objects
- Represent cluster state
- Defined via YAML/JSON

### Examples:
- Pod
- ReplicaSet
- Deployment
- Service

---

## 🏷️ Page 16 — Labels & Selectors
- Key-value pairs
- Used to group and filter resources

---

## 📈 Page 17–18 — Scaling & ReplicaSet
- Ensures desired number of pods
- Replaces failed pods

---

## 🚀 Page 19–21 — Deployment & Rollback
- Supports versioning
- Enables rollback
- Handles scaling

---

## 🌐 Page 22–25 — Networking

### Key Concepts:
- Pod-to-Pod communication
- Service provides stable access
- NodePort exposes externally

---

## 💾 Page 26–28 — Volumes
- Persistent storage
- Survives container restarts

### Types:
- emptyDir
- hostPath
- Persistent Volume (PV)
- Persistent Volume Claim (PVC)

---

## 🔐 Page 29–30 — Secrets & Namespaces

### Secrets:
- Store sensitive data

### Namespaces:
- Logical separation of resources

---

## 🔄 Page 32 — Pod Lifecycle
States:
- Pending
- Running
- Failed
- Succeeded

---

## ✅ Expected Output (Day 50)
- Running local cluster (minikube or kind)
- `kubectl get nodes` working
- Screenshot of cluster ready

---

## 🧭 Final Understanding
Kubernetes is not about running containers.

👉 It is about managing and maintaining systems automatically.

---

## 🚀 Next Step
- Setup cluster
- Run:
```
kubectl get nodes
kubectl run nginx --image=nginx
```

---

## 🧹 Cluster Management Commands (kind + kubectl)

### 🔍 Check System Resources
```bash
# Number of vCPUs
nproc

# Memory usage (human readable)
free -h
```

---

### ⚙️ Install kubectl (Linux ARM64)
```bash
# Download latest stable kubectl for ARM64
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"

# Make it executable
chmod +x kubectl

# Move to system path
sudo mv kubectl /usr/local/bin/

# Verify installation
kubectl version --client
```

---

### 🚀 Create Kubernetes Cluster (kind)
```bash
# Create a cluster named day50-cluster
kind create cluster --name day50-cluster

# Verify cluster is running
kubectl get nodes
```

---

### 🔍 Check Cluster Status
```bash
# List all clusters created by kind
kind get clusters

# View nodes in cluster
kubectl get nodes

# View running pods
kubectl get pods
```

---

### 🧪 Basic kubectl Commands
```bash
# Show kubectl help
kubectl help

# Get cluster info (requires running cluster)
kubectl cluster-info
```

---

### 🗑️ Delete Kubernetes Cluster
```bash
# Delete specific cluster by name
kind delete cluster --name day50-cluster

# Delete default cluster (if no name used)
kind delete cluster
```

---

### 🐳 Debug (Docker Level)
```bash
# List running containers (kind nodes appear here)
docker ps
```

---

### ⚠️ Common Error
```bash
# If no cluster is running, this will fail
kubectl get nodes
# Error: connection refused (expected if cluster not created)
```

---

## 🧠 Key Takeaway
- kubectl → talks to API Server
- kind → creates local Kubernetes cluster using Docker
- etcd → stores cluster state

---

**End of Day 50 Notes**

