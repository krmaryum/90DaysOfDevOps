# Helm Commands Explanation

## 1. Install Helm

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### Explanation
- Downloads the official Helm installation script.
- Automatically detects your OS and architecture.
- Installs Helm binary into `/usr/local/bin/helm`.

---

## 2. Verify Installation

```bash
helm version
```

### Explanation
- Confirms Helm is installed correctly.
- Displays Helm version and build information.

---

## 3. Check Helm Environment

```bash
helm env
```

### Explanation
- Shows all Helm-related environment variables.
- Important paths:
  - `HELM_CONFIG_HOME` → Stores configuration files
  - `HELM_CACHE_HOME` → Stores cached data
  - `HELM_DATA_HOME` → Stores plugins and data

---

## 4. Add a Helm Repository

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

### Explanation
- Adds a new Helm chart repository.
- `bitnami` → Alias (nickname for repo)
- URL → Location of charts
- Does NOT download charts yet.

---

## 5. Update Repository Index

```bash
helm repo update
```

### Explanation
- Downloads the latest list of charts from all added repositories.

---

## 6. List Repositories

```bash
helm repo list
```

### Explanation
- Displays all added repositories.

---

## 7. Search for Charts

```bash
helm search repo bitnami
```

### Explanation
- Searches available charts inside added repositories.

---

## 8. Install an Application

```bash
helm install my-nginx bitnami/nginx
```

### Explanation
- Installs a chart from repository.
- `my-nginx` → Release name
- `bitnami/nginx` → Chart location

---

## 9. List Installed Releases

```bash
helm list
```

### Explanation
- Shows all deployed applications in the cluster.

---

## 10. Uninstall a Release

```bash
helm uninstall my-nginx
```

### Explanation
- Removes the deployed application from Kubernetes.

---

## 11. Important Notes

- Helm is NOT a systemd service.
- It is a CLI tool (runs only when commands are executed).
- Main Kubernetes config used by Helm:

```bash
~/.kube/config
```

- Helm configuration files:

```bash
~/.config/helm/
```

---

## Summary

Helm works like a package manager for Kubernetes:

| Helm Command | Purpose |
|-------------|--------|
| repo add | A