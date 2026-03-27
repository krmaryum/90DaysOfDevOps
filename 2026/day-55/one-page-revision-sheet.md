# Day 55 – PV & PVC (1-Page Revision)

## 🔥 Core Problem
- Containers are **ephemeral**
- Data is lost when Pod is deleted
- Not suitable for:
  - Databases
  - User uploads
  - Logs

---

## 📦 Key Concepts

### PersistentVolume (PV)
- Cluster-wide storage
- Created manually or dynamically
- Exists independent of Pods

### PersistentVolumeClaim (PVC)
- Request for storage
- Namespaced
- Binds to a PV

### Flow
Pod → PVC → PV → Storage

---

## ⚙️ Provisioning Types

### Static Provisioning
- Admin creates PV manually
- PVC binds to existing PV

### Dynamic Provisioning
- PVC triggers automatic PV creation
- Uses StorageClass

---

## 📚 StorageClass

- Defines how storage is created
- Key fields:
  - **Provisioner** → who creates volume
  - **ReclaimPolicy** → Delete / Retain
  - **VolumeBindingMode**
    - Immediate
    - WaitForFirstConsumer

---

## 🔐 Access Modes

- **RWO** → One node (read/write)
- **ROX** → Many nodes (read-only)
- **RWX** → Many nodes (read/write)

---

## 🔄 Reclaim Policy

- **Retain**
  - Keeps data after PVC deletion
  - Manual cleanup required

- **Delete**
  - Deletes storage automatically

---

## 📊 PV Lifecycle

Available → Bound → Released

---

## ⚠️ Important Points

- PV → cluster-wide  
- PVC → namespaced  
- PVC Pending? → check:
  - storage size
  - access mode
  - storageClass  
- `hostPath` → only for learning  
- `storageClassName: ""` → disables dynamic provisioning  

---

## 🧪 What You Practiced

1. Data loss with `emptyDir`
2. Created manual PV (static)
3. Created PVC → Bound to PV
4. Used PVC in Pod → data persists
5. Explored StorageClass
6. Dynamic provisioning (auto PV creation)
7. Reclaim policy behavior (Delete vs Retain)

---

## 🎯 Interview One-Liners

- **Why PVC?**  
  → Decouples storage request from actual storage

- **PV vs PVC?**  
  → PV = storage, PVC = request

- **Why PVC Pending?**  
  → No matching PV or waiting for Pod (WaitForFirstConsumer)

- **Static vs Dynamic?**  
  → Static = manual PV, Dynamic = auto PV via StorageClass

- **Reclaim policy difference?**  
  → Retain keeps data, Delete removes it

---

## ⚡ Final Takeaway

Kubernetes separates:
- **Storage (PV)**
- **Request (PVC)**
- **Provisioning (StorageClass)**

👉 This makes storage flexible, scalable, and persistent across Pod restarts