# Namespace in Kubernetes

In Kubernetes, a namespace is a way to logically divide a cluster into smaller, isolated environments.

## Simple Idea
Think of a Kubernetes cluster like a big apartment building:
- The cluster = the whole building  
- A namespace = each apartment  
- Resources (pods, services, etc.) = things inside each apartment  

Different teams or applications can share the same cluster without interfering with each other.

## Why Namespaces Are Used

### 1. Isolation
Separate environments such as:
- dev
- test
- prod

### 2. Organization
Group related resources together for easier management.

### 3. Resource Control
Set limits for CPU and memory usage per namespace.

### 4. Access Control
Control who can access what using role-based access (RBAC).

## Example

Create a namespace:
```bash
kubectl create namespace my-app
```

Deploy a resource inside it:
```bash
kubectl run nginx --image=nginx -n my-app
```

The nginx pod exists only inside the "my-app" namespace.

## Default Namespaces in Kubernetes
- default → used if no namespace is specified  
- kube-system → system components  
- kube-public → publicly readable resources  
- kube-node-lease → node heartbeat information  

## Key Takeaway
A Kubernetes namespace is like a virtual cluster inside a cluster.
