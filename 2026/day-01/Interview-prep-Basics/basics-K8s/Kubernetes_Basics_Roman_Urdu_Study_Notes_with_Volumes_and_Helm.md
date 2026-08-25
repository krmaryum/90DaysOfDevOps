# Kubernetes Basics — Roman Urdu Study Notes

## 1. Kubernetes kya hai?

**Kubernetes (K8s)** ek **container orchestration platform** hai jo containerized applications ko deploy, manage, scale aur self-heal karne ke liye use hota hai.

Simple flow:

```text
Application
    ↓
Docker Image
    ↓
Container
    ↓
Kubernetes Pod
    ↓
Kubernetes Cluster
```

### Simple Roman Urdu Explanation

Kubernetes ek platform hai jo containerized applications ko deploy, manage, scale aur automatically recover karne mein help karta hai.

---

## 2. Kubernetes Cluster

Kubernetes ka complete environment **Cluster** kehlata hai.

```text
Kubernetes Cluster
│
├── Control Plane
│
└── Worker Nodes
    ├── Pod
    ├── Pod
    └── Pod
```

Ek cluster mein aam tor par do main parts hote hain:

- **Control Plane**
- **Worker Nodes**

---

## 3. Control Plane

**Control Plane** Kubernetes ka brain hota hai.

Ye decide karta hai:

- Pod kis Worker Node par chalega
- Kitne Pods running hone chahiye
- Agar Pod fail ho jaye to kya karna hai
- Cluster ki desired state ko kaise maintain karna hai

### Important Control Plane Components

#### API Server

**API Server** Kubernetes ka main communication point hota hai.

Jab hum `kubectl` command chalate hain to wo API Server ke through cluster se communicate karti hai.

#### Scheduler

**Scheduler** decide karta hai ke naya Pod kis Worker Node par run hoga.

#### Controller Manager

**Controller Manager** continuously check karta hai ke cluster ki actual state aur desired state same hain ya nahi.

Example:

```text
Desired Pods = 3
Actual Pods  = 2

Controller difference detect karta hai
        ↓
Kubernetes ek aur Pod create karta hai
```

#### etcd

**etcd** ek key-value database hai jahan Kubernetes cluster ki configuration aur state information store hoti hai.

---

## 4. Worker Node

**Worker Node** wo server ya virtual machine hota hai jahan actual application workloads run karte hain.

Important Worker Node components:

- kubelet
- kube-proxy
- container runtime
- Pods

### kubelet

**kubelet** har Worker Node par running agent hota hai.

Ye ensure karta hai ke required Pods aur containers properly run kar rahe hon.

### kube-proxy

**kube-proxy** network communication aur Service se Pods tak traffic manage karne mein help karta hai.

### Container Runtime

Container runtime actual containers ko run karta hai.

Examples:

- containerd
- CRI-O

---

## 5. Pod

**Pod** Kubernetes ki smallest deployable unit hoti hai.

Normally ek Pod mein ek main application container run karta hai.

```text
Pod
└── Application Container
```

Useful commands:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

### Roman Urdu Samajh

Pod ko Kubernetes mein application container ka wrapper samajh sakte hain.

---

## 6. Deployment

**Deployment** Pods ko manage karta hai.

Ye kaam kar sakta hai:

- Pods create karna
- Pods update karna
- Desired number of Pods maintain karna
- Rolling updates karna
- Failed Pods ko replace karna

Example:

```text
Deployment
    ↓
ReplicaSet
    ↓
Pods
```

Example desired state:

```yaml
replicas: 3
```

Iska matlab hai ke Kubernetes ko 3 Pods running rakhne hain.

---

## 7. ReplicaSet

**ReplicaSet** ensure karta hai ke required number of Pods running rahen.

Example:

```text
Desired Pods = 3
Actual Pods  = 2
        ↓
ReplicaSet 1 aur Pod create karega
```

Normally hum ReplicaSet ko directly manage nahi karte.

Hum **Deployment** ke through ReplicaSet ko manage karte hain.

---

## 8. Self-Healing

Kubernetes ki ek important capability **self-healing** hai.

Agar koi Pod fail ho jaye to Kubernetes uska replacement automatically create kar sakta hai.

Example:

```text
Failure se pehle:

Pod 1 ✅
Pod 2 ✅
Pod 3 ✅

Pod 2 crash:

Pod 1 ✅
Pod 2 ❌
Pod 3 ✅

Kubernetes replacement create karta hai:

Pod 1 ✅
Pod 3 ✅
Pod 4 ✅
```

---

## 9. Service

Pods temporary hote hain aur unke IP addresses change ho sakte hain.

**Service** Pods ko access karne ke liye stable network endpoint provide karti hai.

```text
User
 ↓
Service
 ↓
├── Pod 1
├── Pod 2
└── Pod 3
```

Service provide kar sakti hai:

- Stable IP address
- Stable DNS name
- Load balancing
- Pods tak access

### Common Service Types

#### ClusterIP

Cluster ke andar internal communication ke liye use hota hai.

#### NodePort

Application ko Worker Node ke port ke through expose karta hai.

#### LoadBalancer

Cloud environment mein application ko external load balancer ke through expose karne ke liye use hota hai.

---

## 10. Namespace

**Namespace** cluster ke resources ko logically separate karta hai.

Example:

```text
Cluster
├── dev
├── test
├── qa
└── prod
```

Useful commands:

```bash
kubectl get namespaces
kubectl get pods -n prod
```

---

## 11. ConfigMap

**ConfigMap** non-sensitive application configuration store karta hai.

Examples:

```text
APP_ENV=production
DATABASE_HOST=db.example.com
LOG_LEVEL=INFO
```

Yani jo configuration secret nahi hai wo ConfigMap mein rakh sakte hain.

---

## 12. Secret

Kubernetes **Secret** sensitive data store karta hai.

Examples:

- Passwords
- Tokens
- API keys
- Certificates

Useful command:

```bash
kubectl get secrets
```

### Interview Difference

```text
ConfigMap → Non-sensitive configuration
Secret    → Sensitive configuration
```

Roman Urdu:

> ConfigMap normal configuration ke liye hota hai, jabke Secret passwords aur tokens jaisi sensitive information ke liye use hota hai.

---

## 13. Ingress

**Ingress** HTTP aur HTTPS traffic ko Kubernetes Services tak route karta hai.

Example:

```text
Internet
   ↓
Ingress
   ↓
------------------------
web.example.com → Web Service
api.example.com → API Service
------------------------
```

Common traffic flow:

```text
User
 ↓
Ingress
 ↓
Service
 ↓
Pods
 ↓
Containers
```

---

## 14. Kubernetes Workload Flow

Important relationship:

```text
Deployment
    ↓
ReplicaSet
    ↓
Pods
    ↓
Containers
```

Cluster level par:

```text
Kubernetes Cluster
        │
        ├── Control Plane
        │
        └── Worker Nodes
                │
                ↓
            Deployment
                ↓
            ReplicaSet
                ↓
               Pods
                ↓
            Containers
```

---

## 15. Scaling

Kubernetes application demand ke mutabiq Pods ki quantity increase ya decrease kar sakta hai.

### Manual Scaling

Example:

```bash
kubectl scale deployment myapp --replicas=5
```

Flow:

```text
Pehle:
Pod
Pod

Scaling ke baad:
Pod
Pod
Pod
Pod
Pod
```

### Horizontal Pod Autoscaler — HPA

**Horizontal Pod Autoscaler (HPA)** metrics ke basis par Pods ko automatically scale kar sakta hai.

Example concept:

```text
Application Load Increase hota hai
          ↓
HPA High Usage Detect karta hai
          ↓
More Pods Create hote hain
```

---

## 16. CrashLoopBackOff

**CrashLoopBackOff** ka matlab hai ke container start hota hai, crash hota hai aur Kubernetes usay baar baar restart karne ki koshish karta hai.

Typical troubleshooting:

```bash
kubectl get pods
kubectl describe pod <pod-name>
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
```

### Common Causes

- Application error
- Wrong environment variable
- Missing Secret
- Bad configuration
- Dependency unavailable
- Port issue
- Memory/resource limit problem

### Troubleshooting Flow

```text
Pod shows CrashLoopBackOff
          ↓
kubectl describe pod
          ↓
Events check karein
          ↓
kubectl logs
          ↓
kubectl logs --previous
          ↓
ConfigMap / Secret / Env vars check karein
          ↓
CPU / Memory limits check karein
```

---

## 17. Useful kubectl Commands

### Nodes Check Karna

```bash
kubectl get nodes
```

### Pods Check Karna

```bash
kubectl get pods
```

### Sab Namespaces ke Pods

```bash
kubectl get pods -A
```

### Deployments Check Karna

```bash
kubectl get deployments
```

### Services Check Karna

```bash
kubectl get services
```

### Pod Detail Check Karna

```bash
kubectl describe pod <pod-name>
```

### Pod Logs Dekhna

```bash
kubectl logs <pod-name>
```

### Previous Crashed Container Logs

```bash
kubectl logs <pod-name> --previous
```

### Running Container ke Andar Jana

```bash
kubectl exec -it <pod-name> -- /bin/bash
```

### Pod Delete Karna

```bash
kubectl delete pod <pod-name>
```

Agar Pod Deployment ke through managed hai to Kubernetes normally replacement Pod create kar deta hai.

### Deployment Scale Karna

```bash
kubectl scale deployment <deployment-name> --replicas=3
```

---


## 18. Kubernetes Volumes

**Volume** Pod ke andar running containers ko storage provide karta hai.

Container ka apna writable filesystem hota hai, lekin uska data temporary ho sakta hai. Jab application ko shared ya persistent storage chahiye ho to Kubernetes Volumes use kiye jate hain.

Simple idea:

```text
Pod
├── Container
└── Volume
     ↓
    Data
```

### Simple Roman Urdu

> Volume ek storage area hota hai jo Pod ke container ko data store karne ke liye diya jata hai.

### Volumes ki Zarurat Kyun Hoti Hai?

Agar suitable persistent storage na ho:

```text
Container / Pod disappear hota hai
        ↓
Temporary data lose ho sakta hai
```

Volume application data ko container ke lifecycle se separate rakhne mein help karta hai.

---

### 18.1 emptyDir

`emptyDir` temporary storage hoti hai jo Pod start hone par create hoti hai.

```text
Pod start
   ↓
emptyDir create
   ↓
Pod ke containers is storage ko use kar sakte hain
```

Important:

> Agar Pod delete ho jaye to `emptyDir` ka data bhi delete ho jata hai.

Common uses:

- Temporary files
- Cache
- Same Pod ke multiple containers ke darmiyan files share karna

---

### 18.2 Persistent Volume — PV

**Persistent Volume (PV)** Kubernetes cluster mein available actual storage resource hota hai.

Actual storage different technologies se aa sakti hai, jaise:

- AWS EBS
- NFS
- Azure Disk
- SAN
- Local storage

Concept:

```text
Kubernetes Cluster
        ↓
Persistent Volume
        ↓
Actual Storage
```

### Roman Urdu

> PV actual storage resource hai jo Kubernetes cluster ko available hota hai.

---

### 18.3 Persistent Volume Claim — PVC

**Persistent Volume Claim (PVC)** storage ki request hoti hai.

Example:

```text
Pod ko 10Gi storage chahiye
        ↓
PVC 10Gi request karta hai
        ↓
Suitable PV select / bind hota hai
        ↓
Pod storage use karta hai
```

Easy memory trick:

```text
PV  = Storage
PVC = Storage ki request
```

Sab se important relationship:

```text
Pod
 ↓
PVC
 ↓
PV
 ↓
Actual Storage
```

### Roman Urdu

> PVC storage maangta hai, PV storage provide karta hai, aur Pod us storage ko use karta hai.

---

### 18.4 PVC Example

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

Pod PVC ko reference kar sakta hai:

```yaml
volumes:
  - name: app-storage
    persistentVolumeClaim:
      claimName: my-pvc
```

Phir container ke andar mount karte hain:

```yaml
volumeMounts:
  - name: app-storage
    mountPath: /data
```

Flow:

```text
Container
   ↓
/data
   ↓
Volume Mount
   ↓
PVC
   ↓
PV
   ↓
Actual Storage
```

---

### 18.5 Access Modes

Common Kubernetes storage access modes:

```text
RWO = ReadWriteOnce
ROX = ReadOnlyMany
RWX = ReadWriteMany
```

#### ReadWriteOnce — RWO

Volume read-write mode mein use hota hai aur commonly ek node se mount kiya jata hai, storage driver ki support ke mutabiq.

#### ReadOnlyMany — ROX

Agar storage backend support kare to multiple nodes volume ko read-only mode mein mount kar sakte hain.

#### ReadWriteMany — RWX

Agar storage backend support kare to multiple nodes volume ko read aur write dono mode mein mount kar sakte hain.

> Access modes ki support storage system aur CSI driver par depend karti hai.

---

### 18.6 StorageClass

**StorageClass** define karti hai ke storage kis tarah dynamically provision honi chahiye.

Dynamic provisioning ke baghair:

```text
Administrator PV create karta hai
        ↓
PVC storage request karta hai
        ↓
PVC suitable PV se bind hota hai
```

StorageClass ke saath:

```text
PVC
 ↓
StorageClass
 ↓
Storage dynamically provision hoti hai
 ↓
PV create / bind hota hai
```

### Roman Urdu

> StorageClass Kubernetes ko batati hai ke storage kis type ki aur kis tarah automatically create karni hai.

---

### 18.7 Useful Volume Commands

Persistent Volumes check karne ke liye:

```bash
kubectl get pv
```

Persistent Volume Claims check karne ke liye:

```bash
kubectl get pvc
```

StorageClasses check karne ke liye:

```bash
kubectl get storageclass
```

Short form:

```bash
kubectl get sc
```

PV ki detail:

```bash
kubectl describe pv <pv-name>
```

PVC ki detail:

```bash
kubectl describe pvc <pvc-name>
```

Pod ke mounted volumes check karne ke liye:

```bash
kubectl describe pod <pod-name>
```

---

### 18.8 Volume Troubleshooting Flow

Agar Pod storage mount nahi kar raha:

```text
Pod Pending / Mount Error
        ↓
kubectl describe pod <pod-name>
        ↓
Events check karein
        ↓
kubectl get pvc
        ↓
Check karein PVC Bound hai ya nahi
        ↓
kubectl describe pvc <pvc-name>
        ↓
PV / StorageClass / CSI driver check karein
```

Common issues:

- PVC `Pending` mein rehna
- Matching PV available na hona
- Wrong StorageClass
- Access mode mismatch
- Storage capacity available na hona
- CSI/storage driver issue
- Permission ya mount problem

---

### 18.9 Interview Definition

> A Kubernetes Volume provides storage to containers running inside a Pod. For persistent application data, Kubernetes commonly uses Persistent Volumes (PV) and Persistent Volume Claims (PVC).

### Roman Urdu

> Kubernetes Volume Pod ke containers ko storage provide karta hai. Persistent data ke liye aam tor par PV aur PVC use kiye jate hain.

### Quick Interview Memory

```text
PVC asks
PV provides
Pod uses
```

Yani:

> **PVC storage maangta hai, PV storage provide karta hai, aur Pod us storage ko use karta hai.**

---


## 19. Helm

**Helm** Kubernetes ka **package manager** hai.

Ye Kubernetes applications ko package, install, upgrade, rollback aur manage karne mein help karta hai.

### Simple Roman Urdu

> Jaise Linux mein `apt` ya `yum` packages install aur manage karte hain, waise Kubernetes mein Helm applications ko install, upgrade aur manage karne ke liye use hota hai.

---

### 19.1 Helm Kyun Useful Hai?

Helm ke baghair ek application deploy karne ke liye multiple Kubernetes YAML files manage karni pad sakti hain:

```text
deployment.yaml
service.yaml
configmap.yaml
secret.yaml
ingress.yaml
```

Helm in files ko ek reusable package mein organize karta hai jise **Chart** kehte hain.

```text
Helm Chart
    ↓
Templates
    ↓
Kubernetes YAML
    ↓
Kubernetes Cluster
```

---

### 19.2 Important Helm Terms

#### Chart

**Chart** Helm ka package hota hai jisme Kubernetes templates aur configuration hoti hai.

Example structure:

```text
mychart/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    └── ingress.yaml
```

Roman Urdu:

> Chart ek package hai jisme application ki Kubernetes configuration aur templates hoti hain.

#### values.yaml

`values.yaml` mein Helm Chart ki configurable values rakhi jati hain.

Example:

```yaml
replicaCount: 3

image:
  repository: nginx
  tag: latest

service:
  type: ClusterIP
  port: 80
```

#### Template

Templates dynamic Kubernetes YAML files hoti hain.

Example:

```yaml
replicas: {{ .Values.replicaCount }}
```

Agar `values.yaml` mein:

```yaml
replicaCount: 3
```

ho, to Helm final YAML mein is value ko render karke:

```yaml
replicas: 3
```

bana sakta hai.

#### Release

Jab Helm Chart Kubernetes cluster mein install hota hai to us installed instance ko **Release** kehte hain.

```text
Chart
  ↓
helm install
  ↓
Release
```

Ek hi Chart ko multiple releases ke naam se install kiya ja sakta hai:

```bash
helm install dev-app ./mychart
helm install prod-app ./mychart
```

---

### 19.3 Basic Helm Commands

Helm version check karna:

```bash
helm version
```

Helm repository add karna:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Repositories update karna:

```bash
helm repo update
```

Chart search karna:

```bash
helm search repo nginx
```

Application install karna:

```bash
helm install my-nginx bitnami/nginx
```

Installed releases dekhna:

```bash
helm list
```

Specific namespace ki releases dekhna:

```bash
helm list -n prod
```

Release upgrade karna:

```bash
helm upgrade my-nginx bitnami/nginx
```

Custom `values.yaml` ke saath upgrade:

```bash
helm upgrade my-nginx bitnami/nginx -f values.yaml
```

Release uninstall karna:

```bash
helm uninstall my-nginx
```

---

### 19.4 Helm Upgrade Flow

```text
Developer configuration change karta hai
        ↓
values.yaml
        ↓
helm upgrade
        ↓
Helm templates render karta hai
        ↓
Kubernetes resources update hote hain
```

Roman Urdu:

> Jab values ya configuration change ho to `helm upgrade` ke through updated configuration Kubernetes cluster mein apply ki ja sakti hai.

---

### 19.5 Helm Rollback

Helm har release ki revision history maintain karta hai.

Release history check karna:

```bash
helm history my-nginx
```

Previous revision par rollback:

```bash
helm rollback my-nginx 1
```

Example:

```text
Release v1 ✅
    ↓
Upgrade v2 ❌
    ↓
helm rollback
    ↓
Release v1 ✅
```

Roman Urdu:

> Agar naya Helm upgrade issue create kare to previous working revision par rollback kiya ja sakta hai.

---

### 19.6 Helm vs kubectl

| kubectl | Helm |
|---|---|
| Kubernetes resources ko directly manage karta hai | Packaged Kubernetes applications manage karta hai |
| Individual YAML files apply kar sakta hai | Charts, templates aur values use karta hai |
| Common command: `kubectl apply -f` | Common commands: `helm install`, `helm upgrade` |
| Resource-level management | Package aur release management |

---

### 19.7 Helm Troubleshooting Basics

Sab releases dekhne ke liye:

```bash
helm list -A
```

Release ki current status:

```bash
helm status <release-name>
```

Release history:

```bash
helm history <release-name>
```

Templates ko install kiye baghair render karke dekhna:

```bash
helm template <release-name> <chart>
```

Actual install ke baghair test karna:

```bash
helm install <release-name> <chart> --dry-run --debug
```

Common Helm issues:

- `values.yaml` mein wrong value
- Template rendering error
- Wrong namespace
- Missing Secret ya ConfigMap
- Image pull failure
- Resource already exist kar raha ho
- Release upgrade failure

### Simple Troubleshooting Flow

```text
Helm release issue
      ↓
helm list -A
      ↓
helm status <release>
      ↓
helm history <release>
      ↓
helm template / --dry-run --debug
      ↓
Kubernetes resources check karein
      ↓
kubectl get pods / describe / logs
```

---

### 19.8 Interview Definition

### English

> Helm is a package manager for Kubernetes that uses Charts to package, install, upgrade, rollback, and manage Kubernetes applications.

### Roman Urdu

> Helm Kubernetes ka package manager hai jo Charts ke through Kubernetes applications ko install, upgrade, rollback aur manage karne mein help karta hai.

### Quick Memory Trick

```text
Chart   = Package
Values  = Configuration
Release = Installed application
```

Important flow:

```text
Helm Chart
    ↓
values.yaml
    ↓
Templates
    ↓
helm install / upgrade
    ↓
Kubernetes Resources
```

---

## 20. Kubernetes Kyun Use Karte Hain?

Main benefits:

### Automation

Deployment aur workload management automate karta hai.

### Scalability

Application ko demand ke mutabiq scale up ya scale down kar sakte hain.

### Self-Healing

Failed Pods ko automatically replace kar sakta hai.

### Portability

Containers ko different environments mein consistently run karne mein help karta hai.

---

## 21. Important Interview Terms

| Term | Roman Urdu Mein Simple Meaning |
|---|---|
| Kubernetes / K8s | Container orchestration platform |
| Cluster | Complete Kubernetes environment |
| Control Plane | Kubernetes ka brain |
| Worker Node | Server jahan Pods run karte hain |
| Pod | Smallest deployable Kubernetes unit |
| Deployment | Pods aur desired state ko manage karta hai |
| ReplicaSet | Required number of Pods maintain karta hai |
| Service | Pods ke liye stable network access |
| Namespace | Resources ki logical separation |
| ConfigMap | Non-sensitive configuration |
| Secret | Sensitive data/configuration |
| Ingress | HTTP/HTTPS traffic route karta hai |
| HPA | Pods ko automatically horizontally scale karta hai |
| CrashLoopBackOff | Container repeatedly crash aur restart hota hai |
| Volume | Pod ke containers ke liye storage |
| PV | Cluster mein persistent storage resource |
| PVC | Persistent storage ki request |
| StorageClass | Storage ko define / dynamically provision karti hai |
| Helm | Kubernetes ka package manager |
| Chart | Helm application package |
| Release | Installed Helm Chart instance |
| values.yaml | Helm Chart ki configurable values |
| kubectl | Kubernetes command-line tool |

---

## 22. One-Line Interview Definition

### English

> Kubernetes is a container orchestration platform used to deploy, scale, manage, and automatically recover containerized applications.

### Roman Urdu

> Kubernetes ek platform hai jo containerized applications ko deploy, manage, scale aur monitor karta hai, aur agar koi Pod fail ho jaye to usay automatically replace bhi kar sakta hai.

---

## 23. Quick Interview Flow Yaad Rakhein

```text
Cluster
  ↓
Control Plane + Worker Nodes
  ↓
Deployment
  ↓
ReplicaSet
  ↓
Pods
  ↓
Containers
```

Traffic:

```text
User
  ↓
Ingress
  ↓
Service
  ↓
Pods
```

Troubleshooting:

```text
kubectl get pods
      ↓
kubectl describe pod
      ↓
kubectl logs
      ↓
Events / Config / Secrets / Resources check karein
```

---

## 24. Final Revision Points

Interview se pehle in topics ko explain karna aana chahiye:

- Kubernetes kya hai
- Cluster architecture
- Control Plane vs Worker Node
- Pod
- Deployment
- ReplicaSet
- Service
- Namespace
- ConfigMap vs Secret
- Ingress
- Scaling
- HPA
- Self-healing
- CrashLoopBackOff
- Kubernetes Volumes
- `emptyDir`
- Persistent Volume (PV)
- Persistent Volume Claim (PVC)
- StorageClass
- RWO / ROX / RWX access modes
- Helm basics
- Helm Chart
- `values.yaml`
- Helm Release
- `helm install`
- `helm upgrade`
- `helm rollback`
- Helm troubleshooting basics
- Basic `kubectl` troubleshooting commands

