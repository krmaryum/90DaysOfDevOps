# Day 59 – Helm — Kubernetes Package Manager

# Task 6 (Helper): Editing values.yaml

## Overview

In a Helm chart, the `values.yaml` file contains default configuration values. These values are injected into Kubernetes templates using Go templating.

In this task, we modify `values.yaml` to change:

* Number of replicas
* Container image version

---

## Objectives

* Open and edit `values.yaml`
* Modify replica count
* Update container image version
* Save and verify changes

---

## Step 1: Navigate to Chart Directory

```bash
cd my-app
```

---

## Step 2: Open values.yaml

### Using vim

```bash
vim values.yaml
```

### Using nano (alternative)

```bash
nano values.yaml
```

---

## Step 3: Modify replicaCount

Find:

```yaml
replicaCount: 1
```

Update to:

```yaml
replicaCount: 3
```

---

## Step 4: Modify Image Configuration

Find:

```yaml
image:
  repository: nginx
  pullPolicy: IfNotPresent
  tag: ""
```

Update to:

```yaml
image:
  repository: nginx
  tag: "1.25"
```

⚠️ Important:

* Maintain correct indentation
* Do not remove spaces before `repository` and `tag`

---

## Step 5: Save the File

### If using vim:

```bash
ESC → :wq → Enter
```

### If using nano:

```bash
CTRL + X → Y → Enter
```

---

## Step 6: Verify Changes

```bash
cat values.yaml
```

Expected output:

```yaml
replicaCount: 3

image:
  repository: nginx
  tag: "1.25"
```

---

## Key Observation

* `values.yaml` defines default configuration
* Templates use these values dynamically
* Changes here affect all future installs of the chart

---

## Why This Matters

Helm templates use:

```yaml
replicas: {{ .Values.replicaCount }}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
```

So modifying `values.yaml` directly controls how your application is deployed.

---

## Conclusion

Editing `values.yaml` is the primary way to customize Helm charts. It allows consistent and reusable configuration across environments without modifying template files.

---
