# Kubernetes Deployment YAML — Beginner Friendly + Detailed Explanation

---

## 📄 YAML with Inline Comments

```yaml
apiVersion: apps/v1        # API version for Deployment resources
kind: Deployment           # Type of resource (Deployment)

metadata:                  # Information about the Deployment
  name: nginx-deployment   # Name of the Deployment
  namespace: dev           # Namespace where it will be created
  labels:                  # Labels for identifying the Deployment
    app: nginx             # Key-value label

spec:                      # Desired state of the Deployment
  replicas: 3              # Number of Pods to run

  selector:                # How Deployment finds its Pods
    matchLabels:
      app: nginx           # Must match Pod labels

  template:                # Blueprint for Pods
    metadata:
      labels:
        app: nginx         # Labels applied to Pods

    spec:                  # Pod specification
      containers:          # List of containers in the Pod
      - name: nginx        # Container name
        image: nginx:1.24  # Container image
        ports:
        - containerPort: 80 # Port exposed by container
```

---

# 🧠 Simple Explanation (Beginner Friendly)

This YAML creates:

👉 A **Deployment** named `nginx-deployment`  
👉 Inside namespace `dev`  
👉 That runs **3 Pods**  
👉 Each Pod runs **Nginx (version 1.24)**

---

# 📦 Block-by-Block Explanation

## 1. API + Kind

- `apiVersion: apps/v1` → Uses Deployment API
- `kind: Deployment` → We are creating a Deployment

---

## 2. Metadata

- `name` → Name of Deployment
- `namespace` → Where it is created
- `labels` → Used for grouping and selection

---

## 3. Spec (Desired State)

- `replicas: 3` → Keep 3 Pods running

---

## 4. Selector

- Tells Deployment which Pods belong to it
- Must match Pod labels exactly

---

## 5. Template (Pod Blueprint)

- Defines how Pods should look
- Includes labels + container config

---

## 6. Pod Spec

- Defines containers inside Pod

### Container Details:
- Name: nginx
- Image: nginx:1.24
- Port: 80

---

# 🔄 How It Works Internally

When you run:

```bash
kubectl apply -f deployment.yaml
```

Kubernetes will:

1. Create Deployment
2. Deployment creates ReplicaSet
3. ReplicaSet creates 3 Pods
4. Each Pod runs nginx container

---

# 🧩 Flow Diagram

```
Deployment
   ↓
ReplicaSet
   ↓
Pods (3)
   ↓
Containers (nginx)
```

---

# ⚠️ Important Rules

## Label Matching

These MUST match:

```yaml
selector.matchLabels.app = nginx
template.metadata.labels.app = nginx
```

Otherwise Deployment will break ❌

---

# 🚀 Final Summary

- Deployment manages Pods automatically
- Keeps desired number of replicas running
- Uses labels to track Pods
- Pods run containers

`apiVersion` → which API version to use

`kind` → what resource to create

`metadata` → identity details like name, namespace, labels

`spec` → desired state

`replicas`: 3 → keep 3 Pods running

`selector` → tells Deployment which Pods belong to it

`template` → blueprint for Pods

`containers` → actual container configuration

`image`: nginx:1.24 → container image

`containerPort`: 80 → app listens on port 80

---

# 🧠 One-Line Summary

👉 This YAML creates a Deployment that runs **3 nginx Pods in the dev namespace**.

