# Day 55 – Persistent Volumes (PV) and Persistent Volume Claims (PVC)

## Table of Contents

| Task | Title | Summary |
|------|------|--------|
| [Task 1](#task-1-see-the-problem--data-lost-on-pod-deletion) | Data Loss with emptyDir | Demonstrates how container data is lost after Pod deletion |
| [Task 2](#task-2-create-a-persistentvolume-static-provisioning) | Create PV (Static) | Manually create a PersistentVolume and verify Available state |
| [Task 3](#task-3-create-a-persistentvolumeclaim) | Create PVC | Request storage and bind it to an existing PV |
| [Task 4](#task-4-use-pvc-in-a-pod) | Use PVC in Pod | Mount PVC in a Pod and verify data persistence |
| [Task 5](#task-5-storageclasses-and-dynamic-provisioning) | StorageClass Basics | Explore provisioner, reclaim policy, and binding mode |
| [Task 6](#task-6-dynamic-provisioning) | Dynamic Provisioning | Auto-create PV using StorageClass via PVC |
| [Task 7](#task-7-clean-up) | Cleanup & Reclaim Policy | Observe Delete vs Retain behavior of PVs |

---

## Quick Summary

- Containers are **ephemeral** → data loss problem  
- **PV** = actual storage (cluster-level)  
- **PVC** = request for storage (namespace-level)  
- **Static provisioning** = manual PV  
- **Dynamic provisioning** = automatic PV via StorageClass  
- **Reclaim policies** control what happens after PVC deletion  

---

## Why Containers Need Persistent Storage

Containers are **ephemeral by design**. This means:
- When a Pod is deleted or restarted, **all data inside it is lost**
- Any files written inside the container filesystem disappear

### Problem
This becomes a serious issue for:
- Databases (MySQL, PostgreSQL)
- Applications storing user uploads
- Logs or stateful data

Example:
If a Pod storing database data crashes, all data is gone — not acceptable in real-world systems.

---

## What are PVs and PVCs?

### Persistent Volume (PV)
- A **cluster-wide storage resource**
- Created by an admin or dynamically provisioned
- Exists independently of Pods

Think of PV as:
> "Actual storage" (disk, cloud volume, etc.)

---

### Persistent Volume Claim (PVC)
- A **request for storage** made by a user
- Defined inside a namespace
- Binds to a matching PV

Think of PVC as:
> "Request for storage"

---

### Relationship (Simple Flow)

1. Admin creates a **PV**
2. User creates a **PVC**
3. Kubernetes matches them
4. Pod uses the PVC

Pod → PVC → PV → Storage


---

## Static vs Dynamic Provisioning

### Static Provisioning
- Admin manually creates PVs
- PVCs bind to existing PVs

Simple but requires manual setup

---

### Dynamic Provisioning
- PVs are created automatically when a PVC is requested
- Uses **StorageClass**

---

### Quick Comparison

| Storage Type    | Lives Where      | Survives Pod Restart | Survives Pod Deletion | Moves Across Nodes |
| --------------- | ---------------- | -------------------- | --------------------- | ------------------ |
| Pod filesystem  | Inside container | ❌ No                 | ❌ No                  | ❌ No               |
| Node filesystem | Node machine     | ✅ Yes                | ✅ Yes                 | ❌ No               |
| Host filesystem | Same as node     | ✅ Yes                | ✅ Yes                 | ❌ No               |

---

### Simple takeaway
- Pod filesystem → temporary, gone when pod dies
- Node/host filesystem → tied to one machine, survives pod but not movement
- PersistentVolume (real storage like EBS, NFS, etc.) → survives      everything and is portable

---

# Task 1: See the Problem — Data Lost on Pod Deletion

## Overview

Containers are **ephemeral**, which means data written inside the container filesystem does not survive when the Pod is deleted.

In this task, we use an `emptyDir` volume to store a timestamped message inside a Pod. Then we delete and recreate the Pod to verify whether the old data remains.

This demonstrates the core storage problem that Persistent Volumes are meant to solve.

---

## Objective

* Create a Pod that writes a timestamped message to a file
* Use an `emptyDir` volume mounted at `/data`
* Verify the file exists inside the running Pod
* Delete and recreate the Pod
* Check whether the old message is still there
* Compare the timestamps before and after recreation

---

## Pod Manifest

Create `ephemeral-pod.yaml`

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ephemeral-pod
spec:
  containers:
    - name: busybox
      image: busybox:latest
      command:
        - sh
        - -c
        - |
          echo "Message written at $(date)" > /data/message.txt
          cat /data/message.txt
          sleep 3600
      volumeMounts:
        - name: temp-storage
          mountPath: /data
  volumes:
    - name: temp-storage
      emptyDir: {}
  restartPolicy: Never
```

### Apply the Pod
```bash
kubectl apply -f ephemeral-pod.yaml
```
```text
pod/ephemeral-pod created
```

### Check Pod status
```bash
kubectl get pods
```
```text
NAME            READY   STATUS    RESTARTS   AGE
ephemeral-pod   1/1     Running   0          92s
```

### Verify the file exists
```bash
kubectl exec ephemeral-pod -- cat /data/message.txt
```
```text
Message written at Thu Mar 26 16:54:14 UTC 2026
```

### Delete the Pod
```bash
kubectl delete pod ephemeral-pod
```
### Check the file again
```text
pod "ephemeral-pod" deleted from default namespace
```

### Verify again the file exists
```bash
kubectl exec ephemeral-pod -- cat /data/message.txt
```
```text
Error from server (NotFound): pods "ephemeral-pod" not found
```

### Recreate the Pod

```bash
kubectl apply -f ephemeral-pod.yaml
```
```text
pod/ephemeral-pod created
```

### Check the file again
```bash
kubectl exec ephemeral-pod -- cat /data/message.txt
```
```text
Message written at Thu Mar 26 17:43:38 UTC 2026
```

## Output Verification
### Before Pod deletion
```text
Message written at Thu Mar 26 16:54:14 UTC 2026
```

### After Pod recreation
```text
Message written at Thu Mar 26 17:43:38 UTC 2026
```

## Key Observation

The timestamp is different after recreating the Pod.

This proves that the data stored in the `emptyDir` volume was lost when the Pod was deleted.

### Why This Happened
- emptyDir exists only for the lifetime of the Pod
- When the Pod is deleted, the volume is also deleted
- Any file stored inside /data is removed with it

So even though the file was successfully created, it was not persistent

### Conclusion

This task demonstrates the problem with ephemeral storage in Kubernetes.
The file inside the Pod was lost after deletion, and a new timestamped file was created when the Pod was recreated.

This is why applications that need to keep data, such as databases, require persistent storage instead of temporary Pod storage.

---

# Task 2: Create a PersistentVolume (Static Provisioning)

## Overview

In this task, we create a **PersistentVolume (PV)** manually using **static provisioning**.

Unlike `emptyDir`, a PV exists **independently of Pods** and can persist data beyond Pod lifecycle.

We will define a PV using `hostPath` for learning purposes.

---

## Objective

* Create a PersistentVolume with:
  - Capacity: `1Gi`
  - Access Mode: `ReadWriteOnce`
  - Reclaim Policy: `Retain`
  - Storage path: `/tmp/k8s-pv-data`
* Apply the PV
* Verify its status using `kubectl get pv`

---

## PersistentVolume Manifest

Create `pv.yaml`

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-static-demo
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ""
  hostPath:
    path: /tmp/k8s-pv-data
```

[`pv.yaml` Explanation](md/persistent_volume_explanation.md)

## Key Fields Explained

### Capacity

```YAML
capacity:
  storage: 1Gi
```
Defines how much storage is available.

### Access Modes
- **ReadWriteOnce (RWO)**
  → Mounted as read-write by a single node
- **ReadOnlyMany (ROX)**
  → Mounted as read-only by many nodes
- **ReadWriteMany (RWX)**
  → Mounted as read-write by many nodes

### Reclaim Policy
```YAML
persistentVolumeReclaimPolicy: Retain
```
- **Retain** → Keeps data even after PVC deletion
- **Delete** → Removes storage automatically

---

### hostPath
```YAML
hostPath:
  path: /tmp/k8s-pv-data
```
- Stores data on the node filesystem
- Good for learning and testing
- ❗ Not recommended for production use

---

### Commands Used
### Apply the PV
```bash
kubectl apply -f pv.yaml
```

---

### Check PV Status
```bash
kubectl get pv
```
```text
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-static-demo   1Gi        RWO            Retain           Available                          <unset>                          13s
```

---

### Output Verification

Expected STATUS:
```text
Available
```

---

### Key Observation
- The PV is successfully created
- It is not yet bound to any PVC
- Therefore, its status is Available

---

### Conclusion

We created a PersistentVolume using static provisioning.\
Since no PVC is requesting it yet, the PV remains in the Available state.

This PV will later be claimed by a PVC to provide persistent storage to a Pod.

---

# Task 3: Create a PersistentVolumeClaim

## Overview

In this task, we create a **PersistentVolumeClaim (PVC)** that requests storage from the cluster.

Kubernetes will automatically match this PVC with an existing **PersistentVolume (PV)** based on:
- Storage size
- Access mode

---

## Objective

* Create a PVC requesting:
  - Storage: `500Mi`
  - Access Mode: `ReadWriteOnce`
* Apply the PVC
* Verify binding using:
  - `kubectl get pvc`
  - `kubectl get pv`

---

## PersistentVolumeClaim Manifest

Create `pvc.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-demo
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  storageClassName: ""
```

---

## Commands Used

### Apply the PVC
```bash
kubectl apply -f pvc.yaml
```

---

### Check PVC Status
```bash
kubectl get pvc
```
```text
NAME       STATUS   VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
pvc-demo   Bound    pv-static-demo   1Gi        RWO                           <unset>                 22s
```

---

### Check PV Status
```bash
kubectl get pv
```
```text
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-static-demo   1Gi        RWO            Retain           Available                          <unset>                          22m
```
---

### Output Verification
PVC Status
```text
Bound
```

---

### Key Observation
- Kubernetes successfully matched:
  - PVC request: 500Mi
  - PV capacity: 1Gi ✅ (sufficient)
- Access modes also match (ReadWriteOnce)
- Binding happens automatically

---

### Important Column Explained
### VOLUME column (kubectl get pvc)
```text
VOLUME: pv-static-demo
```
This shows the name of the PersistentVolume that the PVC is bound to.

---

### Conclusion
- PVC successfully requested storage
- Kubernetes matched it with an existing PV
- Both resources moved to Bound state
- PVC is now ready to be used by a Pod

---

# Task 5: StorageClasses and Dynamic Provisioning

## Overview

In this task, we explore **StorageClasses**, which enable **dynamic provisioning** in Kubernetes.

Instead of manually creating PersistentVolumes (PVs), Kubernetes can automatically create them when a PersistentVolumeClaim (PVC) is requested.

---

## Objective

* List available StorageClasses
* Inspect details of a StorageClass
* Understand:
  - Provisioner
  - Reclaim Policy
  - Volume Binding Mode
* Identify the **default StorageClass**

---

## Commands Used

### List StorageClasses

```bash
kubectl get storageclass
```
```text
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
standard (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  5d1h
```

---

### Describe StorageClass
```bash
kubectl describe storageclass standard
```
```text
Name:            standard
IsDefaultClass:  Yes
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"},"name":"standard"},"provisioner":"rancher.io/local-path","reclaimPolicy":"Delete","volumeBindingMode":"WaitForFirstConsumer"}
,storageclass.kubernetes.io/is-default-class=true
Provisioner:           rancher.io/local-path
Parameters:            <none>
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>
```

---

### Key Fields Explained
### Provisioner
- Defines who creates the volume
- Example:
```text
rancher.io/minikube-hostpath
```
This means Kubernetes will automatically create storage using this plugin

---

### Reclaim Policy
- **Delete** → Volume is deleted when PVC is deleted
- **Retain** → Data is kept

---

# Task 6: Dynamic Provisioning

## Overview

In this task, we use **dynamic provisioning**.

Instead of manually creating a PersistentVolume (PV), we create only a **PVC**, and Kubernetes automatically provisions a PV using the **StorageClass**.

---

## Objective

* Create a PVC using the default StorageClass
* Apply it and verify a PV is created automatically
* Use the PVC in a Pod
* Write and verify data inside the Pod

---

## Step 1: Create PVC (Dynamic)

Create `pvc-dynamic.yaml`

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-dynamic
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  storageClassName: standard
```

### Apply PVC
```bash
kubectl apply -f pvc-dynamic.yaml
```

### Verify PVC
```bash
kubectl get pvc
```
```text
NAME          STATUS    VOLUME           CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
pvc-demo      Bound     pv-static-demo   1Gi        RWO                           <unset>                 105m
pvc-dynamic   Pending                                              standard       <unset>                 81s
```

```bash
kubectl get storageclass
```
```text
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
standard (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  5d2h
```

That `WaitForFirstConsumer` is the important part.

### What it means

With **WaitForFirstConsumer**:

- creating the PVC alone is not enough
- the PVC stays Pending
- Kubernetes waits until a Pod actually uses that PVC
- only then it creates the dynamic PV and binds it

So current status:
``text
pvc-dynamic   Pending
```
is normal until the Pod is created.

---

Step 2: Verify PV Creation

```bash
kubectl get pv
```
```text
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM              STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-static-demo   1Gi        RWO            Retain           Bound    default/pvc-demo                  <unset>                          134m
```

---

Step 3: Use PVC in a Pod
Create `pod-dynamic.yaml`
```YAML
apiVersion: v1
kind: Pod
metadata:
  name: dynamic-pod
spec:
  containers:
    - name: busybox
      image: busybox:latest
      command:
        - sh
        - -c
        - |
          echo "Dynamic PV data $(date)" > /data/message.txt
          cat /data/message.txt
          sleep 3600
      volumeMounts:
        - name: dynamic-storage
          mountPath: /data
  volumes:
    - name: dynamic-storage
      persistentVolumeClaim:
        claimName: pvc-dynamic
  restartPolicy: Never
```

---

### Apply Pod
```text
kubectl apply -f pod-dynamic.yaml
```

---

### Verify PVC again
```bash
kubectl get pvc
```
```bash
NAME          STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
pvc-demo      Bound    pv-static-demo                             1Gi        RWO                           <unset>                 115m
pvc-dynamic   Bound    pvc-d172a27b-be29-4b99-9b53-99a6d95bb918   500Mi      RWO            standard       <unset>                 11m
```

---

### Verify Data
```bash
kubectl exec dynamic-pod -- cat /data/message.txt
```
```text
Dynamic PV data Fri Mar 27 00:49:12 UTC 2026
```

---

### Key Observation
- No manual PV was created this time
- Kubernetes automatically created a PV using the StorageClass
- The Pod successfully used the dynamically provisioned storage

---

### Output Verification
**Total PVs**
```text
2 PVs
```

**Types of PVs**

- Manual PV
  - pv-static-demo
  - Created in Task 2
- Dynamic PV
  - pvc-abc123-xyz (auto-generated name)
  - Created automatically via StorageClass


### Conclusion

Dynamic provisioning removes the need to manually create PersistentVolumes.

Developers only define PVCs, and Kubernetes automatically handles storage creation and binding.

---

# Task 7: Clean Up

## Overview

In this task, we clean up all the resources created in previous steps and observe how Kubernetes handles PersistentVolumes based on their **reclaim policy**.

This helps show the difference between:

- **Delete** → volume is removed automatically
- **Retain** → volume is kept and must be cleaned manually

---

## Objective

- Delete all Pods first
- Delete the PVCs
- Check what happens to the PVs
- Delete the remaining PV manually
- Verify which PV was auto-deleted and which one was retained

---

## Step 1: Delete all Pods

```bash
kubectl delete pod ephemeral-pod dynamic-pod
```
```text
pod "ephemeral-pod" deleted from default namespace
pod "dynamic-pod" deleted from default namespace
```

### Verify
```bash
kubectl get pods
```
```text
kubectl get pods
```

---

### Step 2: Delete the PVCs
```bash
kubectl delete pvc pvc-demo pvc-dynamic
```
```text
persistentvolumeclaim "pvc-demo" deleted from default namespace
persistentvolumeclaim "pvc-dynamic" deleted from default namespace
```

Now check the PVs:
```bash
kubectl get pv
```
```text
NAME             CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM              STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-static-demo   1Gi        RWO            Retain           Released   default/pvc-demo                  <unset>                          4h1m
```

---

### What Happened
**Dynamic PV**

The dynamically created PV was auto-deleted.

Why?

- It was created by the StorageClass
- That StorageClass uses reclaim policy: Delete

So when `pvc-dynamic` was deleted, Kubernetes also removed its PV automatically.

---

### Manual PV

The manually created PV `pv-static-demo` was retained.

Why?

- It was created with:
```YAML
persistentVolumeReclaimPolicy: Retain
```

So after deleting pvc-demo, the PV was not deleted.\
Its status changed to:
```text
Released
```
This means:

- the claim is deleted
- but the PV and its data still remain

---

### Step 3: Delete the Remaining PV Manually
```bash
kubectl delete pv pv-static-demo
```

Verify again:
```bash
kubectl get pv
```
```text
No resources found
```

---

### Final Verification Answer

**Which PV was auto-deleted and which was retained? Why?**

- The dynamic PV was auto-deleted because its reclaim policy was Delete
- The manual PV `pv-static-demo` was retained because its reclaim policy was Retain

---

### Conclusion

This task shows how reclaim policies control what happens to storage after a PVC is deleted.

- Delete removes the PV automatically
- Retain keeps the PV and its data until you remove it manually

---

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

---

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