Q1. Which field in a Kubernetes manifest specifies the resource type?\
A Kubernetes manifest (YAML file) usually looks like this:
```YAML
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
    - name: nginx
      image: nginx
```
The Key Point
✅ kind = Resource Type

This is the correct answer.

- It tells Kubernetes what you are creating
- Examples:
  - `Pod`
  - `Deployment`
  - `Service`
  - `ConfigMap`
👉 So:
```YAML
kind: Pod
```
Means → “Create a Pod”

## ❌ Why the others are wrong
1. apiVersion
- Tells Kubernetes which API version to use
- Example:
```YAMl
apiVersion: apps/v1
```
❗ Not the resource type

2. metadata
- Contains info about the object
- Like:
  - name 
  - labels
  - annotations

3. spec
- Defines how the resource should behave
- Example:
  - containers
  - replicas
  - ports

👉 It describes the configuration, not the type

## 🧩 Simple Analogy

Think of it like ordering food 🍔:
- kind → What you order (burger, pizza)
- metadata → Order name (John's order)
- spec → Customization (extra cheese, no onion)
- apiVersion → Menu version