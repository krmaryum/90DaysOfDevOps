# Day 55 – 5 Command Cheat Sheet

## ⚡ Core Commands

| Purpose | Command |
|--------|--------|
| Apply resources | `kubectl apply -f <file>.yaml` |
| Check PV & PVC | `kubectl get pv && kubectl get pvc` |
| Check StorageClass | `kubectl get storageclass` |
| Verify data inside Pod | `kubectl exec <pod> -- cat /data/message.txt` |
| Clean everything | `kubectl delete pod <pod> && kubectl delete pvc <pvc> && kubectl delete pv <pv>` |

---

## 🧠 How to Think (Fast)

- Data gone? → `emptyDir` problem  
- Need storage? → create PVC  
- PVC Pending? → check StorageClass  
- Auto PV? → dynamic provisioning  
- Data safe after delete? → check reclaim policy  

---

## 🎯 10-Second Interview Flow

1. Create PVC  
2. Kubernetes binds or creates PV  
3. Pod uses PVC  
4. Data persists beyond Pod lifecycle  

👉 Done.