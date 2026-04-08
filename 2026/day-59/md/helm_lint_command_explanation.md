# Helm Lint Command Explanation

## Command

```bash
helm lint my-app
```

---

## What it does

- Checks a Helm chart for errors and best practices.
- Ensures your chart is valid before deployment.

---

## Breakdown

- `helm lint` → Command to validate a chart
- `my-app` → Path to the Helm chart directory

---

## What Helm checks

### 1. Chart Structure
- Validates presence of required files like `Chart.yaml`
- Ensures proper folder structure

### 2. YAML Syntax
- Checks for syntax errors in:
  - `values.yaml`
  - `templates/*.yaml`

### 3. Template Rendering
- Verifies templates render correctly

### 4. Best Practices
- Warns about missing or recommended fields
- Detects deprecated configurations

---

## Example Output

### Success
```bash
==> Linting my-app
[INFO] Chart.yaml: icon is recommended

1 chart(s) linted, 0 chart(s) failed
```

### Error
```bash
[ERROR] templates/deployment.yaml: unable to parse YAML
```

---

## Important Notes

- Does NOT install the chart
- Does NOT interact with Kubernetes cluster
- Used before deployment for validation

---

## When to Use

- Before running `helm install`
- While developing Helm charts
- In CI/CD pipelines

---

## Summary

`helm lint my-app` is used to validate and check your Helm chart for errors before deploying it.

