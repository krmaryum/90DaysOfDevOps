# Helm Template Command Explanation

## Command

```bash
helm template my-release ./my-app
```

---

## What it does

- Renders a Helm chart into Kubernetes YAML manifests.
- Does NOT install anything into the cluster.
- Used to preview what will be deployed.

---

## Breakdown

- `helm template` → Generate Kubernetes YAML from a chart
- `my-release` → Release name (used inside templates)
- `./my-app` → Path to Helm chart directory

---

## What you get

- Fully rendered Kubernetes manifests (Deployment, Service, etc.)
- Output is printed directly to the terminal

---

## Common Use Cases

- Debug Helm templates
- Validate configuration before deployment
- Learn what resources will be created

---

## Examples

### Use custom values file
```bash
helm template my-release ./my-app -f values.yaml
```

### Override values inline
```bash
helm template my-release ./my-app --set replicaCount=3
```

### Save output to file
```bash
helm template my-release ./my-app > output.yaml
```

---

## Important Notes

- Does NOT connect to Kubernetes cluster
- Does NOT create any resources
- Safe to run anytime

---

## Summary

`helm template my-release ./my-app` is used to preview the final Kubernetes YAML generated from your Helm chart before deployment.

