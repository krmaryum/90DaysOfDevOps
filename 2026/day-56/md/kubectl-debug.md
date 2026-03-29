# Kubernetes Debug Pod Command

## Command

```sh
kubectl run -it --rm debug --image=busybox:1.28 --restart=Never -- sh
```

---

## 🔍 What it does

- Creates a pod named `debug`
- Uses the lightweight `busybox:1.28` image
- Opens an **interactive shell session (`sh`)**
- Automatically **deletes the pod when you exit**

---

## 🧩 Breakdown of flags

- `kubectl run` → Creates a pod  
- `-it` → Interactive terminal (`-i` stdin + `-t` TTY)  
- `--rm` → Deletes the pod after exit  
- `debug` → Name of the pod  
- `--image=busybox:1.28` → Uses BusyBox image (small, great for debugging)  
- `--restart=Never` → Ensures it’s a pod, not a Deployment  
- `-- sh` → Runs a shell inside the container  

---

## 💡 When to use this

Use this command when you want to:

- Test **DNS resolution** inside the cluster  
- Check **service connectivity** (`wget`, `nslookup`, etc.)  
- Debug **networking issues**  
- Inspect environment variables or cluster behavior from inside  

---

## 🧪 Example commands inside the pod

Once inside the shell:

```sh
nslookup kubernetes.default
wget http://my-service:8080
ping my-service
```

---

## ⚠️ Notes

- `busybox:1.28` is quite old — consider using:

  ```sh
  --image=busybox:latest
  ```

- BusyBox has limited tools. For more advanced debugging, use:

  - `nicolaka/netshoot`
  - `curlimages/curl`
  - `alpine`

### Example with netshoot:

```sh
kubectl run -it --rm debug --image=nicolaka/netshoot --restart=Never -- bash
```

---

## 🚀 Tip

For modern Kubernetes versions, consider using:

```sh
kubectl debug
```

This provides more advanced debugging capabilities directly on existing pods.
