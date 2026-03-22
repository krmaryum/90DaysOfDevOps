# Day 50 — Kubernetes Commands (With Inline Comments)

## 📊 Quick Commands Table (Day 50)

| Category | Command | Description |
|----------|--------|-------------|
| System Check | `nproc` | Check number of CPU cores |
| System Check | `free -h` | Check memory usage |
| kubectl Install | `kubectl version --client` | Verify kubectl installation |
| kind Install | `kind --version` | Verify kind installation |
| Cluster Create | `kind create cluster --config kind-config.yml` | Create cluster from config |
| Cluster Verify | `kubectl get nodes` | Check cluster nodes status |
| Cluster Info | `kubectl cluster-info` | Show API server & services |
| Node Details | `kubectl describe node <node-name>` | Detailed node info |
| Namespaces | `kubectl get namespaces` | List all namespaces |
| Pods (All) | `kubectl get pods -A` | List all pods across namespaces |
| System Pods | `kubectl get pods -n kube-system` | List system components |
| Pods with Node | `kubectl get pods -n kube-system -o wide` | Show pod placement |
| Delete Cluster | `kind delete cluster --name <name>` | Delete cluster |
| Recreate Cluster | `kind create cluster --name <name>` | Create new cluster |
| Context Check | `kubectl config current-context` | Show active cluster |
| Context List | `kubectl config get-contexts` | List all clusters |
| kubeconfig View | `kubectl config view` | Show full config |
| Debug Docker | `docker ps` | Show running containers |
| Help | `kubectl help` | Show kubectl help |

---

## 🧠 System Check (Before Kubernetes)

```bash
# Check number of CPUs (vCPU)
nproc

# Check memory usage (RAM)
free -h
```

---

## ⚙️ Install kubectl (Linux ARM64)

```bash
# Download latest kubectl binary (ARM64 architecture)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"

# Make kubectl executable
chmod +x kubectl

# Move kubectl to system path
sudo mv kubectl /usr/local/bin/

# Verify kubectl installation
kubectl version --client
```

---

## 🐳 Install kind (Kubernetes in Docker)

```bash
# Download kind for ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-arm64

# Make kind executable
chmod +x ./kind

# Move kind to system path
sudo mv ./kind /usr/local/bin/kind

# Verify installation
kind --version
```

---

## 🏗️ Create Kubernetes Cluster (kind)

```bash
# Navigate to working directory
cd ~/k8s-prac

# Create cluster using config file
kind create cluster --config kind-config.yml

# Verify cluster is running
kubectl get nodes
```

---

## 🔍 Cluster Information

```bash
# Show cluster info (API server + services)
kubectl cluster-info

# List all nodes in cluster
kubectl get nodes

# Show detailed info about a node
kubectl describe node tws-cluster-control-plane

# Show node details (worker nodes)
kubectl describe node tws-cluster-worker
kubectl describe node tws-cluster-worker2
kubectl describe node tws-cluster-worker3
```

---

## 📦 Namespaces & Pods

```bash
# List all namespaces
kubectl get namespaces

# List all pods in all namespaces
kubectl get pods -A

# List system pods (kube-system namespace)
kubectl get pods -n kube-system

# Show pods with node details
kubectl get pods -n kube-system -o wide
```

---

## 🔄 Cluster Lifecycle (kind)

```bash
# Delete existing cluster
kind delete cluster --name tws-cluster

# Create a new cluster
kind create cluster --name devops-cluster

# Verify cluster is running
kubectl get nodes
```

---

## 🔁 Context & kubeconfig Commands

```bash
# Check current active context (cluster)
kubectl config current-context

# List all available contexts
kubectl config get-contexts

# View full kubeconfig (cluster + user + context info)
kubectl config view
```

---

## 🧪 Basic kubectl Commands

```bash
# Show help for kubectl
kubectl help

# Get cluster info using specific context
kubectl cluster-info --context kind-devops-cluster
```

---

## ⚠️ Common Error

```bash
# This will fail if no cluster is running
kubectl get nodes

# Error:
# The connection to the server localhost:8080 was refused
# Reason: No active Kubernetes cluster
```

---

## 🐳 Debug (Docker Level)

```bash
# List running Docker containers (kind nodes)
docker ps
```

---

## 🧠 Key Takeaways

- kubectl → communicates with API Server
- kind → creates local Kubernetes cluster using Docker
- etcd → stores cluster state
- kubeconfig → connects kubectl to cluster
- context → decides which cluster kubectl uses

---

**End of Day 50 Commands**

