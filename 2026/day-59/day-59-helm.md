# Day 59 – Helm — Kubernetes Package Manager

## Table of Contents

| Section                    | Link                                          | Summary                                                              |
| -------------------------- | --------------------------------------------- | -------------------------------------------------------------------- |
| Overview                   | [Overview](#overview)                         | Introduction to Helm and its role in Kubernetes                      |
| Objectives                 | [Objectives](#objectives)                     | Key goals and learning outcomes of the lab                           |
| Task 1: Install Helm       | [Task 1](#task-1-install-helm)                | Installed Helm and verified version (v3.20.1), learned core concepts |
| Task 2: Add Repository     | [Task 2](#task-2-add-a-repository-and-search) | Added Bitnami repo and explored available charts (~145)              |
| Task 3: Install Chart      | [Task 3](#task-3-install-a-chart)             | Deployed nginx using Helm, created resources automatically           |
| Task 4: Customize Values   | [Task 4](#task-4-customize-with-values)       | Used `--set` and values.yaml to customize deployment                 |
| Task 5: Upgrade & Rollback | [Task 5](#task-5-upgrade-and-rollback)        | Upgraded release and rolled back, verified revision history          |
| Task 6: Create Chart       | [Task 6](#task-6-create-your-own-chart)       | Built custom Helm chart and managed replicas                         |
| Task 7: Clean Up           | [Task 7](#task-7-clean-up)                    | Removed all releases and cleaned cluster                             |
| Commands Used              | [Commands](#commands-used)                    | Summary of all Helm and kubectl commands                             |
| Final Summary              | [Final Summary](#final-summary)               | Key takeaways and overall understanding                              |

---


## Overview

In Kubernetes, deploying real-world applications often requires managing multiple resource definitions such as Deployments, Services, ConfigMaps, Secrets, and Persistent Volume Claims. Writing and maintaining these as separate YAML files can quickly become complex and difficult to manage.

Helm simplifies this process by acting as the **package manager for Kubernetes**. It allows developers to bundle multiple Kubernetes resources into a single reusable package called a **chart**. These charts use templating, enabling dynamic configuration and easy customization for different environments.

With Helm, applications can be installed, upgraded, and rolled back efficiently. This makes it an essential tool for managing production-grade Kubernetes workloads.

In this lab, we will install Helm, deploy applications using charts, customize configurations, and create our own Helm chart using templating.

---

## Objectives

* Understand what Helm is and why it is used in Kubernetes
* Learn the three core concepts: Chart, Release, and Repository
* Install Helm and verify the installation
* Explore Helm repositories and install charts
* Customize Helm deployments using values and overrides
* Perform upgrades and rollbacks of Helm releases
* Understand the structure of a Helm chart
* Learn how Helm uses Go templating for dynamic configuration
* Create and deploy a custom Helm chart
* Practice debugging and validating Helm charts using built-in commands

---

# Task 1: Install Helm

## Overview

In Kubernetes, managing multiple YAML files for applications becomes complex as the number of resources grows. Real-world applications often require Deployments, Services, ConfigMaps, Secrets, and Persistent Volumes, making manual management difficult.

Helm simplifies this by acting as the **package manager for Kubernetes**. It allows you to bundle all Kubernetes resources into reusable packages called **charts**, making deployments easier, consistent, and manageable.

In this task, we install Helm, verify the installation, and understand its core concepts.

---

## Objectives

* Understand what Helm is and why it is used
* Learn the three core concepts: Chart, Release, Repository
* Install Helm on the system
* Verify Helm installation using commands
* Explore Helm environment configuration

---

## What is Helm?

Helm is a package manager for Kubernetes that helps you:

* Package applications into charts
* Deploy applications easily
* Customize configurations
* Upgrade and rollback releases

It eliminates the need to manage multiple YAML files manually.

---

## Three Core Concepts

### Chart

A **Chart** is a packaged Kubernetes application that includes:

* YAML templates
* Default configuration values
* Metadata

It acts as a reusable blueprint.

---

### Release

A **Release** is a deployed instance of a chart in the cluster.

* One chart → multiple releases possible
* Each release has a unique name

---

### Repository

A **Repository** is a collection of Helm charts.

* Similar to package repositories like apt or npm
* Example: Bitnami Helm repository

---

## Installation

Helm was installed using the official script:

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | sudo bash
```

---

## Verification

### Check Version

```bash
helm version
```

Output:

```text
version.BuildInfo{Version:"v3.20.1", GitCommit:"a2369ca71c0ef633bf6e4fccd66d634eb379b371", GitTreeState:"clean", GoVersion:"go1.25.8"}
```

---

### Check Environment

```bash
helm env
```
```text
HELM_BIN="helm"
HELM_BURST_LIMIT="100"
HELM_CACHE_HOME="/home/khalid/.cache/helm"
HELM_CONFIG_HOME="/home/khalid/.config/helm"
HELM_DATA_HOME="/home/khalid/.local/share/helm"
HELM_DEBUG="false"
...
...
...
```
---

## Key Observations

* Helm installed successfully
* Version installed: **v3.20.1**
* Default namespace: `default`
* Helm directories created in user home

---

## Verification Answer

**What version of Helm is installed?**

**v3.20.1**

---

## Conclusion

This task demonstrates how to install and verify Helm. Understanding Helm and its core concepts is essential for managing Kubernetes applications efficiently. With Helm installed, we are ready to deploy and manage applications using charts.

---

# Task 2: Add a Repository and Search

## Overview

Helm uses repositories to store and distribute charts. Before installing any application using Helm, we need to add a chart repository.

In this task, we add the **Bitnami repository**, which is one of the most popular and widely used Helm chart repositories. After adding it, we update the repository index and search for available charts.

---

## Objectives

* Add a Helm repository
* Update repository information
* Search for available charts
* Explore charts in the Bitnami repository

---

## Add Bitnami Repository

```bash 
helm repo add bitnami https://charts.bitnami.com/bitnami
```
[helm repo add bitnami https://charts.bitnami.com/bitnami Explained](md/helm_commands_explanation.md)


### Output

```text 
"bitnami" has been added to your repositories
```
### Key takeaway

This command does not install anything

It just adds a source where Helm can download apps from later

---

## Update Repository

```bash 
helm repo update
```

### Output

```text
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈Happy Helming!⎈
```

---

## Search for Charts

### Search for nginx

```bash
helm search repo nginx
```
This shows charts related to nginx.
```text
NAME                                    CHART VERSION   APP VERSION     DESCRIPTION
bitnami/nginx                           22.6.10         1.29.7          NGINX Open Source is a web server that can be a...
bitnami/nginx-ingress-controller        12.0.7          1.13.1          NGINX Ingress Controller is an Ingress controll...
bitnami/nginx-intel                     2.1.15          0.4.9           DEPRECATED NGINX Open Source for Intel is a lig...
```
---

### Search entire Bitnami repo

```bash
helm search repo bitnami
```

This lists all charts available in the Bitnami repository.

---

## Key Observation

* Bitnami repository added successfully
* Repository index updated
* Helm can now fetch charts from Bitnami
* Search command lists available charts with:

  * chart name
  * chart version
  * app version
  * description

---

## Verification Answer

**How many charts does Bitnami have?**

👉 Run:

```bash 
helm search repo bitnami | wc -l
```

Typical output (may vary slightly):

```text 
145
```
Bitnami has approximately 145 charts available (this number may change over time).

So the answer:

**Bitnami has approximately 145 charts available.**

---

## Conclusion

This task demonstrates how to add a Helm repository and explore available charts. By adding the Bitnami repository, we now have access to a large collection of production-ready Kubernetes applications that can be installed using Helm.

---

# Task 3: Install a Chart

## Overview

After adding a Helm repository, we can deploy applications using charts. Helm simplifies Kubernetes deployments by packaging multiple resources into a single install command.

In this task, we install the **nginx chart from the Bitnami repository**, verify the created resources, and inspect the Helm release.

---

## Objectives

* Install a Helm chart
* Verify Kubernetes resources created by Helm
* Inspect Helm release details
* Understand how Helm replaces manual YAML creation

---

## Install nginx Chart

```bash
helm install my-nginx bitnami/nginx
```

### Output

```text
NAME: my-nginx
STATUS: deployed
CHART VERSION: 22.6.10
APP VERSION: 1.29.7
```

---

## Verify Kubernetes Resources

```bash
kubectl get all
```

### Output

```text
pod/my-nginx-866446b5fc-s8dxn   1/1   Running

service/my-nginx     LoadBalancer
deployment.apps/my-nginx   1/1
replicaset.apps/my-nginx-866446b5fc
```

---

## Inspect Helm Release

### List Releases

```bash
helm list
```

Output:

```text
my-nginx   deployed   nginx-22.6.10
```

---

### Check Release Status

```bash
helm status my-nginx
```

Status:

```text
STATUS: deployed
REVISION: 1
```

---

### View Generated Manifests

```bash
helm get manifest my-nginx
```

This shows all generated Kubernetes resources such as:

* Deployment
* Service
* Secret (TLS)
* ServiceAccount
* NetworkPolicy
* PodDisruptionBudget

---

## Key Observation

Helm created multiple resources automatically:

* Deployment
* Service (LoadBalancer)
* Secret (TLS certificates)
* NetworkPolicy
* ServiceAccount

This eliminates the need to manually create multiple YAML files.

---

## Important Concept

Instead of manually creating:

* deployment.yaml
* service.yaml
* secret.yaml
* networkpolicy.yaml

You used:

```bash
helm install my-nginx bitnami/nginx
```

This single command deployed the entire application stack.

---

## Verification Answer

### How many Pods are running?

```bash
kubectl get pods
```

Output:

```text
1 Pod running
```

**Answer: 1 Pod**

---

### What Service type was created?

```bash
kubectl get svc
```

Output:

```text
my-nginx   LoadBalancer
```

**Answer: LoadBalancer**

---

## Conclusion

This task demonstrates the power of Helm in simplifying Kubernetes deployments. With a single command, multiple resources were created and managed automatically. Helm abstracts complexity and enables efficient application deployment and management.

---

# Task 4: Customize with Values

## Overview

Helm charts provide default configurations, but real-world deployments require customization. Helm allows overriding these defaults using command-line flags (`--set`) or configuration files (`values.yaml`).

In this task, we explored default values, customized a release using CLI overrides, and created a reusable values file for deployment.

---

## Objectives

* View default chart values
* Customize deployment using `--set`
* Create a custom values file
* Install a release using a values file
* Verify applied configurations

---

## View Default Values

```bash
helm show values bitnami/nginx
```

This displays configurable parameters such as:

* replicaCount
* service.type
* resources

---

## Install Custom Release using --set

```bash
helm install nginx-custom bitnami/nginx --set replicaCount=3 --set service.type=NodePort
```

---

## Verify Resources

```bash
kubectl get pods
```

Output:

```text
nginx-custom → 3 Pods running
```

---

```bash
kubectl get svc
```

Output:

```text
nginx-custom   NodePort
```

---

## Create custom-values.yaml

```yaml
replicaCount: 2

service:
  type: NodePort

resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 250m
    memory: 256Mi
```

---

## Install Release using Values File

```bash
helm install nginx-values bitnami/nginx -f custom-values.yaml
```

---

## Verify Applied Values

```bash
helm get values nginx-values --all
```

Key Output:

```text
replicaCount: 2
service:
  type: NodePort
resources:
  limits:
    cpu: 250m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
```

---

## Verify Kubernetes Resources

```bash
kubectl get pods
```

Output:

```text
nginx-values → 2 Pods running
```

---

```bash
kubectl get svc
```

Output:

```text
nginx-values   NodePort
```

---

## Key Observations

* `--set` allows quick overrides but is not ideal for complex configs
* `values.yaml` is reusable and preferred for production
* Helm merges default values with overrides
* Multiple releases can coexist with different configurations

---

## Verification Answer

### Does the values file release have correct replicas?

**Yes — 2 Pods are running**

---

### Does it have correct Service type?

**Yes — Service type is NodePort**

---

## Conclusion

This task demonstrates how Helm enables flexible configuration management. Using both CLI overrides and values files, we can customize deployments efficiently. The values file approach is scalable and recommended for real-world applications.

---

# Task 5: Upgrade and Rollback

## Overview

Helm allows modifying an existing release using upgrades while keeping a full history of changes. Each upgrade creates a new revision, making it easy to track changes and revert if needed.

Rollback restores a previous version of the release without deleting history. Instead, Helm creates a new revision representing the rollback.

In this task, we upgraded the `my-nginx` release and then rolled it back to the original version.

---

## Objectives

* Upgrade an existing Helm release
* View release history
* Perform a rollback
* Understand Helm revision tracking

---

## Upgrade Release

```bash 
helm upgrade my-nginx bitnami/nginx --set replicaCount=5
```

### Output

```text 
STATUS: deployed
REVISION: 2
```

---

## Check History

```bash 
helm history my-nginx
```

### Output

```text 
REVISION  STATUS       DESCRIPTION
1         superseded   Install complete
2         deployed     Upgrade complete
```

---

## Rollback to Revision 1

```bash 
helm rollback my-nginx 1
```

### Output

```text 
Rollback was a success!
```

---

## Check History After Rollback

```bash 
helm history my-nginx
```

### Output

```text 
REVISION  STATUS       DESCRIPTION
1         superseded   Install complete
2         superseded   Upgrade complete
3         deployed     Rollback to 1
```

---

## Key Observations

* Upgrade created **Revision 2**
* Rollback did **not overwrite Revision 2**
* Rollback created a **new Revision 3**
* Full history is preserved

---

## Important Concept

Helm maintains a **versioned history of releases**:

* Revision 1 → Initial install
* Revision 2 → Upgrade
* Revision 3 → Rollback

This is similar to Deployment rollouts, but Helm manages the **entire application stack**, not just Pods.

---

## Verification Answer

**How many revisions are there after the rollback?**

**3 revisions**

---

## Conclusion

This task demonstrates Helm’s powerful release management capabilities. By maintaining a full history of revisions, Helm allows safe upgrades and easy rollbacks, making it ideal for production environments where reliability and traceability are critical.

---

# Task 6: Create Your Own Chart

## Overview

Helm allows creating custom charts to package Kubernetes applications. Using `helm create`, we can scaffold a ready-to-use chart structure and customize it using values and templates.

In this task, we created a custom Helm chart, modified its configuration, validated it, previewed the generated manifests, installed it, and upgraded it.

---

## Objectives

* Create a Helm chart scaffold
* Understand chart structure
* Modify `values.yaml`
* Validate chart using `helm lint`
* Preview manifests using `helm template`
* Install and upgrade the chart
* Verify replica changes

---

## Create Chart

```bash
helm create my-app
```

Chart structure:

```text
my-app/
  Chart.yaml
  values.yaml
  templates/
  charts/
```

---

## Modify values.yaml

Updated:

```yaml 
replicaCount: 3

image:
  repository: nginx
  tag: "1.25"
```

---

## Validate Chart

```bash 
helm lint my-app
```
[helm lint my-app Explained](md/helm_lint_command_explanation.md)

Output:

```text 
1 chart(s) linted, 0 chart(s) failed
```

---

## Preview Templates

```bash 
helm template my-release ./my-app
```
[helm template my-release Explained](md/helm_template%20my-release_command_explanation.md)

### Key Output

```yaml 
replicas: 3
image: nginx:1.25
```

This confirms that values are correctly injected into templates.

---

## Install Chart

```bash 
helm install my-release ./my-app
```

---

## Verify Installation

```bash 
kubectl get pods
```

Output:

```text 
my-release-my-app → 3 Pods running
```

---

## Upgrade Release

```bash 
helm upgrade my-release ./my-app --set replicaCount=5
```

---

## Verify Upgrade

```bash 
kubectl get pods
```

Output:

```text 
my-release-my-app → 5 Pods running
```

---

## Key Observations

* `helm create` generates a full chart structure
* `values.yaml` controls deployment behavior
* Templates dynamically inject values using Go syntax
* `helm lint` validates chart correctness
* `helm template` previews manifests without deploying
* Upgrade successfully changed replicas from 3 → 5

---

## Important Concept

Helm templates use Go templating:

```yaml
replicas: {{ .Values.replicaCount }}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

This allows dynamic configuration of Kubernetes resources.

---

## Verification Answer

**After installing, were there 3 replicas?**

**Yes — 3 Pods running**

**After upgrading, were there 5 replicas?**

**Yes — 5 Pods running**

---

## Conclusion

This task demonstrates how to build and manage a custom Helm chart. By combining templates and values, Helm enables reusable, configurable Kubernetes applications. The ability to install, preview, and upgrade charts makes Helm a powerful tool for modern DevOps workflows.

Helm uses Go templating to dynamically render Kubernetes manifests before applying them to the cluster.

---

# Task 7: Clean Up

## Overview

After completing all Helm operations, it is important to clean up resources to maintain a healthy Kubernetes environment. Helm provides an easy way to uninstall releases, which removes all associated Kubernetes resources.

In this task, we removed all Helm releases, verified the cluster state, and cleaned up local files.

---

## Objectives

* Uninstall all Helm releases
* Verify removal of resources
* Clean up local files
* Ensure cluster is in a clean state

---

## List Existing Releases

```bash
helm list
```

### Output

```text 
my-nginx
my-release
nginx-custom
nginx-values
```

---

## Uninstall Releases

```bash 
helm uninstall my-nginx
helm uninstall nginx-custom
helm uninstall nginx-values
helm uninstall my-release
```

### Output

```text 
release "my-nginx" uninstalled
release "nginx-custom" uninstalled
release "nginx-values" uninstalled
release "my-release" uninstalled
```

---

## Verify Helm Cleanup

```bash 
helm list
```

### Output

```text 
No releases found
```

---

## Verify Kubernetes Resources

### Pods

```bash 
kubectl get pods
```

Output:

```text 
No resources found in default namespace.
```

---

### Services

```bash 
kubectl get svc
```

Output:

```text 
kubernetes   ClusterIP   10.96.0.1
```

Default Kubernetes service remains (expected)

---

## Remove Local Files

```bash 
rm -rf ../task-6/my-app
```

---

## Key Observations

* All Helm releases successfully removed
* All Pods deleted automatically
* Only default Kubernetes service remains
* Local chart directory removed
* Cluster is clean and ready for reuse

---

## Verification Answer

**Does `helm list` show zero releases?**

**Yes — no releases are present after cleanup**

---

## Conclusion

This task demonstrates proper cleanup of Helm-managed resources. Uninstalling releases removes all associated Kubernetes objects, ensuring a clean cluster state. Cleanup is essential for avoiding conflicts and maintaining an efficient development environment.

---

## Commands Used

| Command                                                                                    | Description                            |
| ------------------------------------------------------------------------------------------ | -------------------------------------- |
| `helm version`                                                                             | Check installed Helm version           |
| `helm env`                                                                                 | Display Helm environment configuration |
| `helm repo add bitnami https://charts.bitnami.com/bitnami`                                 | Add Bitnami chart repository           |
| `helm repo update`                                                                         | Update repository index                |
| `helm search repo nginx`                                                                   | Search for nginx charts                |
| `helm search repo bitnami`                                                                 | List all charts in Bitnami repo        |
| `helm install my-nginx bitnami/nginx`                                                      | Install nginx chart                    |
| `kubectl get all`                                                                          | View all Kubernetes resources          |
| `helm list`                                                                                | List all Helm releases                 |
| `helm status my-nginx`                                                                     | Check release status                   |
| `helm get manifest my-nginx`                                                               | View generated manifests               |
| `helm show values bitnami/nginx`                                                           | View default chart values              |
| `helm install nginx-custom bitnami/nginx --set replicaCount=3 --set service.type=NodePort` | Install with custom CLI values         |
| `helm install nginx-values bitnami/nginx -f custom-values.yaml`                            | Install using values file              |
| `helm get values nginx-values --all`                                                       | Show applied values                    |
| `helm upgrade my-nginx bitnami/nginx --set replicaCount=5`                                 | Upgrade release                        |
| `helm history my-nginx`                                                                    | View revision history                  |
| `helm rollback my-nginx 1`                                                                 | Roll back to previous revision         |
| `helm create my-app`                                                                       | Generate new Helm chart                |
| `helm lint my-app`                                                                         | Validate chart structure               |
| `helm template my-release ./my-app`                                                        | Render templates without installing    |
| `helm install my-release ./my-app`                                                         | Install custom chart                   |
| `helm upgrade my-release ./my-app --set replicaCount=5`                                    | Upgrade custom chart                   |
| `helm uninstall <release-name>`                                                            | Remove Helm release                    |
| `kubectl get pods`                                                                         | Check running Pods                     |
| `kubectl get svc`                                                                          | Check Services                         |
| `rm -rf my-app`                                                                            | Delete chart directory                 |

---

## Final Summary

In this lab, we explored Helm as the package manager for Kubernetes and learned how it simplifies application deployment and management.

We installed Helm, added repositories, and deployed applications using charts. We customized deployments using CLI overrides and values files, performed upgrades and rollbacks, and created our own Helm chart using templates and configuration values.

Key takeaways:

* Helm packages Kubernetes resources into reusable charts  
* Releases track deployed instances with full revision history  
* Values allow flexible and dynamic configuration  
* Helm simplifies complex deployments into single commands  
* Custom charts enable reusable and scalable application definitions  

This lab demonstrates how Helm is used in real-world DevOps workflows to manage Kubernetes applications efficiently and reliably.