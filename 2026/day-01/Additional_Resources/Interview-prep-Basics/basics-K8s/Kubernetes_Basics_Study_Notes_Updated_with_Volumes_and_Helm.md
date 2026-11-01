# Kubernetes Basics — Study Notes

## 1. What is Kubernetes?

**Kubernetes (K8s)** is a **container orchestration platform** used to deploy, manage, scale, and self-heal containerized applications.

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

A complete Kubernetes environment is called a **Cluster**.

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

A cluster mainly contains:

- **Control Plane**
- **Worker Nodes**

---

## 3. Control Plane

The **Control Plane** is the brain of Kubernetes.

It decides:

- Where a Pod should run
- How many Pods should be running
- What to do if a Pod fails
- How to maintain the desired state of the cluster

### Important Control Plane Components

#### API Server

The **API Server** is the main communication point for Kubernetes.

`kubectl` commands communicate with the Kubernetes cluster through the API Server.

#### Scheduler

The **Scheduler** decides which Worker Node should run a new Pod.

#### Controller Manager

The **Controller Manager** continuously checks whether the actual state of the cluster matches the desired state.

Example:

```text
Desired Pods = 3
Actual Pods  = 2

Controller detects the difference
        ↓
Kubernetes creates another Pod
```

#### etcd

**etcd** is a key-value database used by Kubernetes to store cluster configuration and state information.

---

## 4. Worker Node

A **Worker Node** is a server or virtual machine where application workloads actually run.

Important Worker Node components include:

- kubelet
- kube-proxy
- container runtime
- Pods

### kubelet

The **kubelet** is an agent running on every Worker Node.

It makes sure the required Pods and containers are running.

### kube-proxy

**kube-proxy** helps manage network communication and traffic between Kubernetes Services and Pods.

### Container Runtime

The container runtime actually runs containers.

Examples may include:

- containerd
- CRI-O

---

## 5. Pod

A **Pod** is the smallest deployable unit in Kubernetes.

Usually, one Pod runs one main application container.

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

### Roman Urdu

Pod ko Kubernetes mein application container ka wrapper samajh sakte hain.

---

## 6. Deployment

A **Deployment** manages Pods.

It can:

- Create Pods
- Update Pods
- Maintain the desired number of Pods
- Perform rolling updates
- Replace failed Pods

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

This means Kubernetes should keep 3 Pods running.

---

## 7. ReplicaSet

A **ReplicaSet** ensures that the required number of Pods remain running.

Example:

```text
Desired Pods = 3
Actual Pods  = 2
        ↓
ReplicaSet creates 1 more Pod
```

Normally, we manage ReplicaSets through a **Deployment** rather than creating them directly.

---

## 8. Self-Healing

Kubernetes provides **self-healing**.

If a Pod fails, Kubernetes can create a replacement automatically.

Example:

```text
Before failure:

Pod 1 ✅
Pod 2 ✅
Pod 3 ✅

Pod 2 crashes:

Pod 1 ✅
Pod 2 ❌
Pod 3 ✅

Kubernetes creates replacement:

Pod 1 ✅
Pod 3 ✅
Pod 4 ✅
```

---

## 9. Service

Pods are temporary and their IP addresses may change.

A **Service** provides a stable way to access a group of Pods.

```text
User
 ↓
Service
 ↓
├── Pod 1
├── Pod 2
└── Pod 3
```

A Service can provide:

- Stable IP address
- Stable DNS name
- Load balancing
- Access to Pods

### Common Service Types

#### ClusterIP

Used for internal communication inside the Kubernetes cluster.

#### NodePort

Exposes an application through a port on the Worker Node.

#### LoadBalancer

Commonly used in cloud environments to expose an application using an external load balancer.

---

## 10. Namespace

A **Namespace** logically separates resources inside a Kubernetes cluster.

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

A **ConfigMap** stores non-sensitive application configuration.

Examples:

```text
APP_ENV=production
DATABASE_HOST=db.example.com
LOG_LEVEL=INFO
```

Use ConfigMap for configuration that is not secret.

---

## 12. Secret

A Kubernetes **Secret** stores sensitive data.

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

---

## 13. Ingress

**Ingress** routes HTTP and HTTPS traffic to Kubernetes Services.

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

A common traffic flow is:

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

And at the cluster level:

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

Kubernetes can increase or decrease the number of Pods based on application demand.

### Manual Scaling

Example:

```bash
kubectl scale deployment myapp --replicas=5
```

Flow:

```text
Before:
Pod
Pod

After scaling:
Pod
Pod
Pod
Pod
Pod
```

### Horizontal Pod Autoscaler — HPA

The **Horizontal Pod Autoscaler (HPA)** can automatically scale Pods based on metrics such as CPU or memory usage.

Concept:

```text
Application Load Increases
          ↓
HPA Detects Higher Usage
          ↓
More Pods Are Created
```

---

## 16. CrashLoopBackOff

**CrashLoopBackOff** means a container starts, crashes, and Kubernetes repeatedly tries to restart it.

Typical troubleshooting steps:

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
- Memory/resource limit issue

### Troubleshooting Flow

```text
Pod shows CrashLoopBackOff
          ↓
kubectl describe pod
          ↓
Check Events
          ↓
kubectl logs
          ↓
kubectl logs --previous
          ↓
Check ConfigMap / Secret / Env vars
          ↓
Check CPU / Memory limits
```

---

## 17. Useful kubectl Commands

### Check Nodes

```bash
kubectl get nodes
```

### Check Pods

```bash
kubectl get pods
```

### Check Pods in All Namespaces

```bash
kubectl get pods -A
```

### Check Deployments

```bash
kubectl get deployments
```

### Check Services

```bash
kubectl get services
```

### Describe a Pod

```bash
kubectl describe pod <pod-name>
```

### View Pod Logs

```bash
kubectl logs <pod-name>
```

### View Previous Container Logs

```bash
kubectl logs <pod-name> --previous
```

### Enter a Running Container

```bash
kubectl exec -it <pod-name> -- /bin/bash
```

### Delete a Pod

```bash
kubectl delete pod <pod-name>
```

If the Pod is managed by a Deployment, Kubernetes normally creates a replacement automatically.

### Scale a Deployment

```bash
kubectl scale deployment <deployment-name> --replicas=3
```

---

## 18. Kubernetes Volumes

A **Volume** provides storage to containers running inside a Pod.

Containers have their own writable filesystem, but that data may be temporary. Kubernetes Volumes are used when an application needs shared or persistent storage.

Simple idea:

```text
Pod
├── Container
└── Volume
     ↓
    Data
```

### Roman Urdu

> Volume ek storage area hota hai jo Pod ke container ko data store karne ke liye diya jata hai.

### Why Volumes Are Needed

Without suitable persistent storage:

```text
Container / Pod disappears
        ↓
Temporary data may be lost
```

Volumes help separate application data from the container lifecycle.

---

### 18.1 emptyDir

`emptyDir` is temporary storage created when a Pod starts.

```text
Pod starts
   ↓
emptyDir created
   ↓
Containers inside the Pod can use it
```

Important:

> If the Pod is deleted, the `emptyDir` data is also deleted.

Common uses:

- Temporary files
- Cache
- Sharing files between containers in the same Pod

---

### 18.2 Persistent Volume — PV

A **Persistent Volume (PV)** is a storage resource available to the Kubernetes cluster.

The actual storage may come from technologies such as:

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

A **Persistent Volume Claim (PVC)** is a request for storage.

Example:

```text
Pod needs 10Gi storage
        ↓
PVC requests 10Gi
        ↓
Suitable PV is selected/bound
        ↓
Pod uses the storage
```

Easy memory trick:

```text
PV  = Storage
PVC = Storage ki request
```

Most important relationship:

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

### 18.4 Example PVC

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

A Pod can reference the PVC:

```yaml
volumes:
  - name: app-storage
    persistentVolumeClaim:
      claimName: my-pvc
```

Then mount it inside the container:

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

The volume can be mounted read-write according to the storage driver's supported access semantics, commonly from a single node at a time.

#### ReadOnlyMany — ROX

The volume can be mounted read-only by multiple nodes, if supported by the storage backend.

#### ReadWriteMany — RWX

The volume can be mounted read-write by multiple nodes, if supported by the storage backend.

> Access mode support depends on the storage system and CSI driver.

---

### 18.6 StorageClass

A **StorageClass** defines how storage should be dynamically provisioned.

Without dynamic provisioning:

```text
Administrator creates PV
        ↓
PVC requests storage
        ↓
PVC binds to suitable PV
```

With StorageClass:

```text
PVC
 ↓
StorageClass
 ↓
Storage is dynamically provisioned
 ↓
PV is created/bound
```

### Roman Urdu

> StorageClass Kubernetes ko batati hai ke storage kis type ki aur kis tarah automatically create karni hai.

---

### 18.7 Useful Volume Commands

Check Persistent Volumes:

```bash
kubectl get pv
```

Check Persistent Volume Claims:

```bash
kubectl get pvc
```

Check StorageClasses:

```bash
kubectl get storageclass
```

Short form:

```bash
kubectl get sc
```

Describe a PV:

```bash
kubectl describe pv <pv-name>
```

Describe a PVC:

```bash
kubectl describe pvc <pvc-name>
```

Check a Pod to see its mounted volumes:

```bash
kubectl describe pod <pod-name>
```

---

### 18.8 Volume Troubleshooting Flow

If a Pod cannot mount storage:

```text
Pod Pending / Mount Error
        ↓
kubectl describe pod <pod-name>
        ↓
Check Events
        ↓
kubectl get pvc
        ↓
Is PVC Bound?
        ↓
kubectl describe pvc <pvc-name>
        ↓
Check PV / StorageClass / CSI driver
```

Common issues:

- PVC remains `Pending`
- No matching PV
- Wrong StorageClass
- Access mode mismatch
- Storage capacity unavailable
- CSI/storage driver issue
- Permission or mount problem

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

---


## 19. Helm

**Helm** is a **package manager for Kubernetes**.

It helps package, install, upgrade, rollback, and manage Kubernetes applications.

### Simple Roman Urdu

> Jaise Linux mein `apt` ya `yum` packages install aur manage karte hain, waise Kubernetes mein Helm applications ko install, upgrade aur manage karne mein help karta hai.

---

### 19.1 Why Helm Is Useful

Without Helm, an application may require several Kubernetes YAML files:

```text
deployment.yaml
service.yaml
configmap.yaml
secret.yaml
ingress.yaml
```

Helm organizes these files into a reusable package called a **Chart**.

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

A **Chart** is a Helm package that contains Kubernetes templates and configuration.

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

`values.yaml` contains configurable values for a Helm Chart.

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

Templates are dynamic Kubernetes YAML files.

Example:

```yaml
replicas: {{ .Values.replicaCount }}
```

If `values.yaml` contains:

```yaml
replicaCount: 3
```

Helm can render the final value as:

```yaml
replicas: 3
```

#### Release

When a Chart is installed into a Kubernetes cluster, that installed instance is called a **Release**.

```text
Chart
  ↓
helm install
  ↓
Release
```

The same Chart can be installed as multiple releases:

```bash
helm install dev-app ./mychart
helm install prod-app ./mychart
```

---

### 19.3 Basic Helm Commands

Check Helm version:

```bash
helm version
```

Add a Helm repository:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Update repositories:

```bash
helm repo update
```

Search for a Chart:

```bash
helm search repo nginx
```

Install an application:

```bash
helm install my-nginx bitnami/nginx
```

List installed releases:

```bash
helm list
```

List releases in a namespace:

```bash
helm list -n prod
```

Upgrade a release:

```bash
helm upgrade my-nginx bitnami/nginx
```

Upgrade using a custom values file:

```bash
helm upgrade my-nginx bitnami/nginx -f values.yaml
```

Uninstall a release:

```bash
helm uninstall my-nginx
```

---

### 19.4 Helm Upgrade Flow

```text
Developer changes configuration
        ↓
values.yaml
        ↓
helm upgrade
        ↓
Helm renders templates
        ↓
Kubernetes resources are updated
```

---

### 19.5 Helm Rollback

Helm keeps revision history for a release.

Check release history:

```bash
helm history my-nginx
```

Rollback to an earlier revision:

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

---

### 19.6 Helm vs kubectl

| kubectl | Helm |
|---|---|
| Directly manages Kubernetes resources | Manages packaged Kubernetes applications |
| Can apply individual YAML files | Uses Charts containing templates and values |
| Common command: `kubectl apply -f` | Common commands: `helm install`, `helm upgrade` |
| Resource-level management | Package and release management |

---

### 19.7 Helm Troubleshooting Basics

Useful commands:

```bash
helm list -A
```

```bash
helm status <release-name>
```

```bash
helm history <release-name>
```

Preview rendered templates before installing:

```bash
helm template <release-name> <chart>
```

Test an install without actually installing:

```bash
helm install <release-name> <chart> --dry-run --debug
```

Common issues:

- Wrong value in `values.yaml`
- Template rendering error
- Wrong namespace
- Missing Secret or ConfigMap
- Image pull failure
- Resource already exists
- Release upgrade failure

---

### 19.8 Interview Definition

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

## 20. Why Kubernetes?

Main benefits:

### Automation

Automates deployment and workload management.

### Scalability

Applications can scale up or down based on demand.

### Self-Healing

Failed Pods can be automatically replaced.

### Portability

Containerized applications can run consistently across different environments.

---

## 21. Important Interview Terms

| Term | Simple Meaning |
|---|---|
| Kubernetes / K8s | Container orchestration platform |
| Cluster | Complete Kubernetes environment |
| Control Plane | Brain of Kubernetes |
| Worker Node | Server where Pods run |
| Pod | Smallest deployable Kubernetes unit |
| Deployment | Manages Pods and desired state |
| ReplicaSet | Maintains required number of Pods |
| Service | Stable network access to Pods |
| Namespace | Logical separation of resources |
| ConfigMap | Non-sensitive configuration |
| Secret | Sensitive configuration/data |
| Ingress | Routes HTTP/HTTPS traffic |
| HPA | Automatically scales Pods horizontally |
| CrashLoopBackOff | Container repeatedly crashes and restarts |
| Volume | Storage used by containers in a Pod |
| PV | Persistent storage resource in the cluster |
| PVC | Request for persistent storage |
| StorageClass | Defines/dynamically provisions storage |
| Helm | Kubernetes package manager |
| Chart | Helm application package |
| Release | Installed instance of a Helm Chart |
| values.yaml | Configurable values for a Helm Chart |
| kubectl | Kubernetes command-line tool |

---

## 22. One-Line Interview Definition

> Kubernetes is a container orchestration platform used to deploy, scale, manage, and automatically recover containerized applications.

### Roman Urdu

> Kubernetes ek platform hai jo containerized applications ko deploy, manage, scale aur monitor karta hai, aur agar koi Pod fail ho jaye to usay automatically replace bhi kar sakta hai.

---

## 23. Quick Interview Flow to Remember

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
Check Events / Config / Secrets / Resources
```

---

## 24. Final Revision Points

Before an interview, make sure you can explain:

- What Kubernetes is
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
- `helm install`, `helm upgrade`, `helm rollback`
- Basic `kubectl` troubleshooting commands

