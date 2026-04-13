# kubectl config view --minify | grep namespace:

## Command
```bash
kubectl config view --minify | grep namespace:
```

## Explanation

This command shows the currently set default namespace in your Kubernetes configuration.

---

## Breaking it down

### kubectl config view --minify
- Displays your kubeconfig
- Shows only the current context

### | grep namespace:
- Filters the output to only lines containing 'namespace:'
- Helps quickly identify the namespace

---

## Example Output
```bash
namespace: capstone
```

This means your current default namespace is `capstone`.

---

## Why this is useful

- Quickly verify your current namespace
- Helps avoid deploying to the wrong namespace
- Useful after setting a namespace with kubectl config

---

## Key Takeaway

This command is a quick way to check your current Kubernetes namespace.
