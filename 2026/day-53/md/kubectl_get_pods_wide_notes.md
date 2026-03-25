# kubectl get pods -o wide (Interview Notes)

## What does this command do?

It lists all Pods with additional detailed information compared to the default output.

---

## Command

kubectl get pods -o wide

---

## Breakdown

### kubectl get pods
- Fetches list of Pods from Kubernetes cluster
- Uses REST API call to API Server

### -o wide
- -o = output format
- wide = shows additional details

---

## Default vs Wide Output

### Default Output
NAME         READY   STATUS    RESTARTS   AGE
web-app-abc  1/1     Running   0          2m

### Wide Output
NAME         READY   STATUS    RESTARTS   AGE   IP           NODE        NOMINATED NODE   READINESS GATES
web-app-abc  1/1     Running   0          2m    10.244.0.5   worker-node  <none>           <none>

---

## Important Columns

- IP → Pod internal IP
- NODE → Node where Pod is running
- NOMINATED NODE → Used during scheduling
- READINESS GATES → Custom readiness checks

---

## Why use -o wide?

- Debugging
- Identify node placement
- Check Pod networking
- Useful in multi-node clusters

---

## Real Use Cases

1. Find where Pod is running
kubectl get pods -o wide

2. Check Pod IP for networking/debugging

---

## Behind the Scenes

kubectl → API Server → fetch Pod objects → display extra fields

---

## Interview One-Liner

kubectl get pods -o wide shows additional details like node name and Pod IP, useful for debugging and understanding cluster distribution.

---

## Pro Tip

kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns
