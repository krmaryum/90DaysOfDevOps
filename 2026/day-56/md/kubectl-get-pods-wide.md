# kubectl get pods -o wide

## Command

```sh
kubectl get pods -o wide
```

---

## 🔍 What it does

- Lists all pods in the current namespace  
- Adds **extra details** compared to the default output  

---

## 📊 Example Output

```sh
NAME        READY   STATUS    RESTARTS   AGE   IP           NODE           NOMINATED NODE   READINESS GATES
nginx-abc   1/1     Running   0          2d    10.244.0.5   worker-node-1  <none>           <none>
```

---

## 🧩 Column Breakdown

- **NAME** → Pod name  
- **READY** → Containers ready / total containers  
- **STATUS** → Current state (Running, Pending, CrashLoopBackOff, etc.)  
- **RESTARTS** → Number of container restarts  
- **AGE** → How long the pod has been running  
- **IP** → Pod’s internal cluster IP  
- **NODE** → Node where the pod is running  
- **NOMINATED NODE** → Used for scheduling (usually empty)  
- **READINESS GATES** → Advanced readiness checks  

---

## 💡 Why -o wide is useful

Without `-o wide`, you don’t see:
- Pod IP (important for networking/debugging)  
- Node placement (important for scheduling issues)  

---

## 🛠️ Common variations

### Get pods in all namespaces
```sh
kubectl get pods -A -o wide
```

### Watch pods in real time
```sh
kubectl get pods -o wide -w
```

### Get specific namespace
```sh
kubectl get pods -n my-namespace -o wide
```

---

## 🚨 Debugging tips

- **Pod stuck in Pending?** → Check node resources / scheduling  
- **CrashLoopBackOff?** → Use:
  ```sh
  kubectl logs <pod-name>
  ```
- **Wrong node?** → Check node selectors / affinity rules  
