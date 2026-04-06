# Day 58 – Metrics Server and Horizontal Pod Autoscaler (HPA)

## Table of Contents

| Task | Title                              | Summary                                                                                                                            | Link                                                          |
| ---- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| 1    | Metrics Server Installation        | Install and configure the Metrics Server to collect real-time CPU and memory usage from nodes and Pods                             | [Go to Task 1](#task-1-install-the-metrics-server)            |
| 2    | Explore kubectl top                | Use `kubectl top` to observe live resource usage and understand the difference between actual usage and configured requests/limits | [Go to Task 2](#task-2-explore-kubectl-top)                   |
| 3    | Deployment with CPU Requests       | Create a Deployment with CPU requests so HPA can calculate utilization percentages correctly                                       | [Go to Task 3](#task-3-create-a-deployment-with-cpu-requests) |
| 4    | HPA (Imperative)                   | Create an HPA using an imperative command and understand how TARGETS reflect CPU utilization vs target                             | [Go to Task 4](#task-4-create-an-hpa-imperative)              |
| 5    | Load Testing & Autoscaling         | Generate load to trigger HPA scaling and observe how replicas increase based on CPU usage                                          | [Go to Task 5](#task-5-generate-load-and-watch-autoscaling)   |
| 6    | HPA (Declarative - autoscaling/v2) | Create an HPA using YAML with advanced behavior controls for scaling speed and stabilization                                       | [Go to Task 6](#task-6-create-an-hpa-from-yaml-declarative)   |
| 7    | Clean Up                           | Remove all created resources while keeping the Metrics Server installed for future use                                             | [Go to Task 7](#task-7-clean-up)                              |


## Overview

In Kubernetes, resource requests and limits define how much CPU and memory a Pod should use. However, to scale applications dynamically based on real usage, Kubernetes needs visibility into actual resource consumption.

The Metrics Server collects CPU and memory usage from nodes and Pods, enabling commands like `kubectl top`. This data is essential for the Horizontal Pod Autoscaler (HPA), which automatically adjusts the number of Pod replicas based on workload demand.

[Explain Metrics Server](md/metrics_server_explained.md)

---

## Objectives

- Understand what the Metrics Server is and why it is required  
- Install and verify the Metrics Server  
- Use `kubectl top` to observe real resource usage  
- Prepare for HPA-based autoscaling  

---

# Task 1: Install the Metrics Server

## Overview

The Metrics Server is a cluster-wide Kubernetes component that collects real-time CPU and memory usage from nodes and Pods. It exposes this information through the Kubernetes Metrics API, which powers commands such as `kubectl top`.

The Horizontal Pod Autoscaler (HPA) depends on this data to make scaling decisions. Without it, Kubernetes cannot scale workloads based on actual usage.

---

## Objective

- Install the Metrics Server in the cluster  
- Configure it for a kind environment  
- Verify node and pod metrics  
- Confirm CPU and memory usage  

---

## Commands Used

### Apply Metrics Server
```bash
kubectl apply -f components.yaml
```
### Edit Deployment (TLS Fix)

[In local kind clusters, strict TLS verification may prevent the Metrics Server from communicating with kubelets.](md/metrics_server_complete_notes.md)

```bash
kubectl edit deployment metrics-server -n kube-system
```
Added:
```YAML
- --kubelet-insecure-tls
```

### Wait for rollout
```bash
kubectl rollout status deployment metrics-server -n kube-system
```
### Verify
```bash
kubectl top nodes  
kubectl top pods -A  
```
---

## Output

### kubectl top nodes
```text
NAME                           CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)
devops-cluster-control-plane   449m         3%       1128Mi          14%
```
### kubectl top pods -A

```text
kube-system   metrics-server-xxxxx   10m   17Mi
kube-system   kube-apiserver-xxxxx   102m  226Mi
```

---

## Key Observation

- Metrics Server installed successfully  
- Deployment rolled out without issues  
- Node and pod metrics are available  
- Metrics API is working  
- This data will be used by the Horizontal Pod Autoscaler (HPA) in the next tasks
---

## Verification Answer

**Current node usage:**

- CPU: 449m (3%)  
- Memory: 1128Mi (14%)  

---

## Conclusion

The Metrics Server is successfully installed and working. Kubernetes can now observe real-time resource usage, enabling autoscaling in later tasks.

---

# Task 2: Explore kubectl top

## Overview

The `kubectl top` command provides real-time CPU and memory usage for nodes and Pods in a Kubernetes cluster. This data is collected by the Metrics Server and reflects actual resource consumption rather than configured requests or limits.

This information is essential for understanding workload behavior and is used by the Horizontal Pod Autoscaler (HPA) to make scaling decisions.

---

## Objective

- View node-level resource usage  
- View pod-level resource usage across all namespaces  
- Sort Pods by CPU usage  
- Identify the Pod consuming the most CPU  

---

## Commands Used

```bash
kubectl top nodes
```
```text
NAME                           CPU(cores)   CPU(%)   MEMORY(bytes)   MEMORY(%)
devops-cluster-control-plane   391m         3%       1037Mi          13% 
```
[kubectl top nodes Explanation](md/kubectl_top_nodes_explained.md)

### What this means overall
Your node is:

- Lightly loaded
- Metrics Server is working
- System is stable

### Simple summary
- 391m → ~0.39 CPU used
- 3% → very low CPU load
- 1037Mi → ~1GB RAM used
- 13% → low memory usage

```bash
kubectl top pods -A
```
```text
NAMESPACE            NAME                                                   CPU(cores)   MEMORY(bytes)
kube-system          coredns-7d764666f9-4rpz4                               8m           13Mi
kube-system          coredns-7d764666f9-5dh2l                               4m           13Mi
kube-system          etcd-devops-cluster-control-plane                      67m          50Mi
kube-system          kindnet-klvmw                                          3m           28Mi
kube-system          kube-apiserver-devops-cluster-control-plane            117m         222Mi
kube-system          kube-controller-manager-devops-cluster-control-plane   57m          49Mi
kube-system          kube-proxy-plp75                                       3m           18Mi
kube-system          kube-scheduler-devops-cluster-control-plane            26m          25Mi
kube-system          metrics-server-5f54fb74d9-5kvgt                        12m          20Mi
local-path-storage   local-path-provisioner-67b8995b4b-vvj45                2m           8Mi
```

[kubectl top pods -A Explained](md/kubectl_top_pods_explained.md)

### What this tells you overall

Your cluster is:

- Healthy
- Lightweight
- Running only system workloads
- Metrics Server working correctly

### Key Observations
- API server uses most memory → expected
- Everything else is low usage → cluster idle
- No abnormal spikes → stable system

### Connect this with previous command
kubectl get pods -A → STATUS
kubectl top pods -A → USAGE

Together:

| Command | Purpose |
|--------|--------|
| kubectl get pods | Check if Pods are running |
| kubectl top pods | Check resource usage |


```bash
kubectl top pods -A --sort-by=cpu
```
[kubectl top pods -A --sort-by=cpu Explained](md/kubectl_top_pods_sorted_cpu.md)

```text
NAMESPACE            NAME                                                   CPU(cores)   MEMORY(bytes)
kube-system          kube-apiserver-devops-cluster-control-plane            117m         222Mi
kube-system          etcd-devops-cluster-control-plane                      75m          49Mi
kube-system          kube-controller-manager-devops-cluster-control-plane   57m          49Mi
kube-system          kube-scheduler-devops-cluster-control-plane            27m          25Mi
kube-system          metrics-server-5f54fb74d9-5kvgt                        17m          20Mi
kube-system          coredns-7d764666f9-4rpz4                               5m           13Mi
kube-system          coredns-7d764666f9-5dh2l                               4m           13Mi
kube-system          kube-proxy-plp75                                       3m           18Mi
kube-system          kindnet-klvmw                                          2m           28Mi
local-path-storage   local-path-provisioner-67b8995b4b-vvj45                1m           8Mi
```

### What this sorting tells you

This is super useful in real-world debugging 

Now you can instantly see:

- Which pod is consuming the most CPU
- Where your bottlenecks are


### Quick mental model
kubectl top pods  → shows usage
kubectl top pods --sort-by=cpu → shows priorities (who is heavy)
Nodes → overall machine usage
Pods → individual app usage

---

# Task 3: Create a Deployment with CPU Requests

## Overview

To use the Horizontal Pod Autoscaler with CPU-based scaling, the application must define a CPU request. HPA calculates CPU utilization as a percentage of the requested CPU, not the CPU limit and not raw CPU usage alone.

In this task, a Deployment is created using the `registry.k8s.io/hpa-example` image, which runs a CPU-intensive PHP-Apache server. The container is configured with a CPU request of `200m`, then exposed through a Service.

---

## Objective

- Create a Deployment for the `php-apache` application
- Set `resources.requests.cpu: 200m`
- Expose the Deployment as a Service
- Verify that the Pod is running
- Check the current CPU usage of the Pod

---
## Step 1 — Create the manifest
## Deployment Manifest
Create php-apache.yaml
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  replicas: 1
  selector:
    matchLabels:
      app: php-apache
  template:
    metadata:
      labels:
        app: php-apache
    spec:
      containers:
        - name: php-apache
          image: php:8.2-apache
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: 200m
```
[php-apache.yaml Explained](md/php_apache_real_image_explained.md)

### Step 2 — Apply it
```bash
kubectl apply -f php-apache.yaml
```
```text
deployment.apps/php-apache created
```

### Step 3 — Expose it as a Service
```bash
kubectl expose deployment php-apache --port=80
```
```text
service/php-apache exposed
```

### Step 4 — Verify the Pod is running
```bash
kubectl get pods
kubectl get svc
```
```text
NAME                          READY   STATUS    RESTARTS   AGE
php-apache-567cd7dc5b-sklmx   1/1     Running   0          20s

NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1     <none>        443/TCP   14d
php-apache   ClusterIP   10.96.13.12   <none>        80/TCP    24m
```

### Step 5 — Check current CPU usage
```bash
kubectl top pods | grep php-apache
```
```text
NAME                          CPU(cores)   MEMORY(bytes)
php-apache-567cd7dc5b-sklmx   50m          12Mi
```

### Key Observation
- The Pod is running successfully
- The container has a CPU request of 200m
- HPA requires this request value to calculate CPU utilization percentage
- The current CPU usage is lower than the requested CPU, which means utilization is currently low

### Verification Answer

### What is the current CPU usage of the Pod?

The `php-apache` Pod is currently using 50m CPU.

### Conclusion

This task prepares the application for Horizontal Pod Autoscaling by ensuring the Deployment has a CPU request defined and is exposed through a Service. With the Pod now running successfully, Kubernetes can measure utilization and use it in the next HPA task.

---

# Task 4: Create an HPA (Imperative)

## Overview

The Horizontal Pod Autoscaler (HPA) automatically adjusts the number of Pod replicas based on resource utilization. In this task, an HPA is created using the imperative command to scale the `php-apache` Deployment based on CPU usage.

The HPA compares the current CPU utilization against a target percentage (50%) and scales the Deployment up or down accordingly.

---

## Objective

- Create an HPA using an imperative command  
- Set CPU utilization target to 50%  
- Define minimum and maximum replicas  
- Verify HPA status and metrics  
- Understand the TARGETS column  

---

## Commands Used


### Step 1 — Create the HPA

```bash
kubectl autoscale deployment php-apache --cpu-percent=50% --min=1 --max=10
```
It creates a Horizontal Pod Autoscaler (HPA) for your Deployment.

Automatically increase or decrease pods based on CPU usage

[kubectl autoscale deployment php-apache --cpu-percent=50% --min=1 --max=10](md/hpa_command_explained.md)

```text
horizontalpodautoscaler.autoscaling/php-apache autoscaled
```

### Step 2 — Check HPA
```bash
kubectl get hpa
```
```text
NAME         REFERENCE               TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   cpu: 0%/50%   1         10        1          3m52s
```

```bash
kubectl describe hpa php-apache
```

```text
NAME         REFERENCE               TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   cpu: 0%/50%   1         10        1          3m52s
khalid@Khalid-laptop:~/k8s-prac/day-58/task-4$ kubectl describe hpa php-apache
Name:                                                  php-apache
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Sun, 05 Apr 2026 13:31:49 -0500
Reference:                                             Deployment/php-apache
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  0% (1m) / 50%
Min replicas:                                          1
Max replicas:                                          10
Deployment pods:                                       1 current / 1 desired
Conditions:
  Type            Status  Reason            Message
  ----            ------  ------            -------
  AbleToScale     True    ReadyForNewScale  recommended size matches current size
  ScalingActive   True    ValidMetricFound  the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  True    TooFewReplicas    the desired replica count is less than the minimum replica count
Events:           <none>
```
### Understand TARGETS (VERY IMPORTANT)

Format:

<current_usage%> / <target%>

Example:

25%/50% → current CPU is 25%, target is 50%
80%/50% → above target → will scale up

### Verification answer

What does the TARGETS column show?

It shows:

cpu: 0%/50%

That means:

- current average CPU utilization = 0% of requested CPU
- target utilization = 50%

In `describe`, Kubernetes shows the same in more detail:

- current CPU usage = 1m
- target = 50% of request

Since your request is `200m`, `1m` is effectively near 0% after rounding.

--Key Observation
- The HPA was created successfully
- It is monitoring CPU utilization as a percentage of the configured CPU request
- The target utilization is 50%
- The current utilization is 0%, based on a current CPU usage of 1m
- Since the desired replica count is below the minimum, the Deployment remains at 1 replica
- The HPA is active and able to calculate scaling decisions correctly

### Conclusion

This task demonstrates how to create a Horizontal Pod Autoscaler using an imperative command. The HPA is successfully tracking CPU utilization for the php-apache Deployment and is ready to scale the application when CPU usage increases.

### HPA Formula

desiredReplicas = ceil(currentReplicas × (currentCPU / targetCPU))

---

# Task 5: Generate Load and Watch Autoscaling

## Overview

To test autoscaling behavior, artificial load was generated against the `php-apache` Service using a BusyBox Pod. This increased CPU usage on the application Pod, allowing the Horizontal Pod Autoscaler to detect utilization above the configured target and add more replicas.

This task demonstrates how HPA responds dynamically to changing workload demand.

---

## Objective

- Generate continuous HTTP load against the application
- Watch HPA react to increased CPU usage
- Observe replica count increase under load
- Stop the load generator after scaling is confirmed

---

## Commands Used

### Generate Load and Watch Autoscaling

### Step 1 — Start the load generator

```bash
kubectl run load-generator --image=busybox:1.36 --restart=Never -- /bin/sh -c "while true; do wget -q -O- http://php-apache; done"
```

### Step 2 — Watch the HPA

In another terminal, run:
```bash
kubectl get hpa php-apache --watch
```
You should watch:

- current CPU utilization rise
- replicas increase above 1

```text
NAME         REFERENCE               TARGETS        MINPODS   MAXPODS   REPLICAS   AGE
php-apache   Deployment/php-apache   cpu: 12%/50%   1         10        1          145m
php-apache   Deployment/php-apache   cpu: 60%/50%   1         10        1          145m
php-apache   Deployment/php-apache   cpu: 60%/50%   1         10        2          145m
php-apache   Deployment/php-apache   cpu: 57%/50%   1         10        2          145m
php-apache   Deployment/php-apache   cpu: 31%/50%   1         10        2          146m
```

### Step 3 — Stop the load

When you’ve seen scaling happen, stop it:
```bash
kubectl delete pod load-generator
```
You do not need to wait for scale-down because Kubernetes usually keeps a 5-minute stabilization window before reducing replicas.

### Key Observation
- The HPA target CPU utilization was 50%
- Under load, CPU utilization increased from 12% to 60%
- Once CPU exceeded the target, the HPA scaled the Deployment from 1 replica to 2 replicas
- After scaling, CPU utilization decreased toward the target
- This shows HPA successfully reacting to live application demand

### Verification Answer

How many replicas did HPA scale to under load?

2 replicas

### Conclusion

This task confirms that the Horizontal Pod Autoscaler works as expected. When CPU usage rose above the configured target, Kubernetes automatically increased the number of replicas to handle the load.


---

# Task 6: Create an HPA from YAML (Declarative)

## Overview

The imperative HPA command is useful for quickly creating a basic autoscaler, but it cannot define advanced scaling rules. The `autoscaling/v2` API supports multiple metrics and allows fine-grained control over scaling behavior through the `behavior` section.

In this task, a declarative HPA manifest was created using `autoscaling/v2`, with a CPU target of `50%`, immediate scale-up behavior, and slower scale-down behavior.

---

## Objective

- Create a declarative HPA using `autoscaling/v2`
- Set CPU target utilization to `50%`
- Configure scale-up and scale-down behavior
- Verify the HPA configuration using `kubectl describe hpa`

---

## Commands Used
### Step 1 — Delete the imperative HPA

Run:
```bash
kubectl delete hpa php-apache
```
### Step 2 — Create the declarative HPA manifest

### Apply the HPA manifest
Create `php-apache-hpa.yaml`

```YAML
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: php-apache
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: php-apache
  minReplicas: 1
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
  behavior:
    scaleUp:
      stabilizationWindowSeconds: 0
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
    scaleDown:
      stabilizationWindowSeconds: 300
      policies:
        - type: Percent
          value: 100
          periodSeconds: 15
```

[php-apache-hpa.yaml Expalined](md/hpa_v2_explained.md)

### What this does
- target CPU utilization = `50%`
- `scaleUp.stabilizationWindowSeconds: 0`
   - scale up immediately when needed
- `scaleDown.stabilizationWindowSeconds: 300`
   - wait 5 minutes before scaling down
- policies define how aggressively Kubernetes can change replica count

### Step 3 — Apply it
```bash
kubectl apply -f php-apache-hpa.yaml
```

```text
horizontalpodautoscaler.autoscaling/php-apache created
```

### Mental model
```text
Metrics Server → CPU data
HPA → evaluates
Behavior rules → control speed
Deployment → adjusts pods
```

### Step 4 — Verify it
```bash
kubectl describe hpa php-apache
```
```text
Name:                                                  php-apache
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Sun, 05 Apr 2026 23:06:25 -0500
Reference:                                             Deployment/php-apache
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  0% (1m) / 50%
Min replicas:                                          1
Max replicas:                                          10
Behavior:
  Scale Up:
    Stabilization Window: 0 seconds
    Select Policy: Max
    Policies:
      - Type: Percent  Value: 100  Period: 15 seconds
  Scale Down:
    Stabilization Window: 300 seconds
    Select Policy: Max
    Policies:
      - Type: Percent  Value: 100  Period: 15 seconds
Deployment pods:       1 current / 1 desired
Conditions:
  Type            Status  Reason               Message
  ----            ------  ------               -------
  AbleToScale     True    ScaleDownStabilized  recent recommendations were higher than current one, applying the highest recent recommendation
  ScalingActive   True    ValidMetricFound     the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange   the desired count is within the acceptable range
Events:           <none>
```
### HPA Formula

desiredReplicas = ceil(currentReplicas × (currentCPU / targetCPU))

### Verification answer

What does the behavior section control?

It controls how the HPA scales up and scales down over time.

From your output:

- Scale Up
   - stabilization window = 0 seconds
   - can increase replicas quickly
- Scale Down
   - stabilization window = 300 seconds
   - waits before reducing replicas to avoid rapid downscaling
- Policies
   - control the rate of scaling changes
   - here: up to 100% change every 15 seconds

So the short answer is:

The behavior section controls scaling speed, stabilization timing, and how aggressively replica counts can change.

### Conclusion

This task demonstrates the advantage of declarative HPA configuration with `autoscaling/v2`. Unlike the imperative command, it supports advanced scaling behavior, making autoscaling more predictable and tunable.

# Task 7: Clean Up

## Overview

After completing all tasks, it is important to clean up Kubernetes resources to avoid unnecessary resource usage and ensure a clean environment for future labs. The Metrics Server is left running because it is a cluster-level component required for monitoring and autoscaling.

---

## Objective

- Delete the HPA
- Delete the Service
- Delete the Deployment
- Delete the load generator Pod
- Verify that all resources are removed
- Keep the Metrics Server running

---

## Commands Used

### Delete HPA

```bash
kubectl delete hpa php-apache
```
```text
horizontalpodautoscaler.autoscaling "php-apache" deleted from default namespace
```
### Delete Service
```bash
kubectl delete service php-apache
```
```text
service "php-apache" deleted from default namespace
```

### Delete Deployment
```bash
kubectl delete deployment php-apache
```
```text
deployment.apps "php-apache" deleted from default namespace
```
### Delete Load Generator
```bash
kubectl delete pod load-generator
```
```text
Error from server (NotFound): pods "load-generator" not found
```
Alredy deleted in task-6

### Verification
```bash
kubectl get all
```
```text
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   16d
```

### Expected Output:

No `php-apache` resources
No `load-generator` Pod
Only system components remain

### Key Observation
- All application-related resources were successfully deleted
- The cluster is now clean and ready for future tasks
- The Metrics Server remains installed and operational

### Verification Answer

Are all resources deleted successfully?

Yes

### Conclusion

This task ensures proper cleanup of Kubernetes resources. Maintaining a clean cluster environment is important for preventing conflicts and conserving system resources.