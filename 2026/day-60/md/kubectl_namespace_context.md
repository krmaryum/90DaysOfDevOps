# kubectl config set-context --current --namespace=capstone

## Command
```bash
kubectl config set-context --current --namespace=capstone
```

## Explanation

This command tells kubectl:

“From now on, use the `capstone` namespace by default.”

---

## Breaking it into parts

### kubectl config set-context
- Updates your Kubernetes configuration (kubeconfig)
- Modifies a context (cluster + user + namespace combo)

### --current
- Applies the change to the currently active context

### --namespace=capstone
- Sets the default namespace to `capstone`
- Removes the need to type `-n capstone` in every command

---

## Before vs After

### Before:
```bash
kubectl get pods -n capstone
```

### After:
```bash
kubectl get pods
```

Now it automatically uses the `capstone` namespace.

---

## Why this is useful

- Saves time
- Reduces mistakes
- Keeps commands cleaner

---

## Important Note

This command:
- Only affects your local configuration
- Does NOT create the namespace
- Does NOT change the cluster itself

---

## Key Idea

It sets a default namespace for your current Kubernetes context.
