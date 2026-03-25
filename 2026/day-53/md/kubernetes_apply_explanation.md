# What Happens Inside Kubernetes After `kubectl apply`

## Step-by-Step Explanation

### 1. kubectl sends your YAML to the API Server
- kubectl reads your file (Deployment object)
- Converts YAML to JSON
- Sends a REST API request to the Kubernetes API Server

### 2. API Server validates & stores it
- Authenticates the request
- Validates schema
- Applies defaults
- Stores object in etcd

### 3. Deployment Controller kicks in
- Notices desired state (3 replicas)
- Creates a ReplicaSet

### 4. ReplicaSet creates Pods
- Ensures 3 Pods are created

### 5. Scheduler assigns Pods to Nodes
- Picks nodes based on resources and rules

### 6. Kubelet starts containers
- Pulls nginx:1.25 image
- Starts containers
- Opens port 80

### 7. Pod becomes Running
- Containers start successfully
- Pod status becomes Running

## Continuous Reconciliation
Kubernetes continuously ensures desired state:
- Replaces failed Pods
- Reschedules Pods if nodes fail

## Mental Model
You say: "I want 3 nginx Pods"
Kubernetes handles:
- API Server → stores request
- Deployment → desired state
- ReplicaSet → ensures count
- Scheduler → assigns nodes
- Kubelet → runs containers

## Why kubectl apply matters
- Declarative approach
- Applies only changes (diff + patch)

## Example Output
```bash
kubectl get pods
```
```text
web-app-xxxxx   Running
web-app-yyyyy   Running
web-app-zzzzz   Running
```

