# kubectl run test-client (Interview Notes)

## Command

kubectl run test-client --image=busybox:latest --rm -it --restart=Never -- sh

---

## What does it do?

Creates a temporary interactive BusyBox Pod, opens a shell inside it, and deletes it automatically after exit.

---

## Breakdown

### kubectl run test-client
- Creates a Pod named test-client
- Used for quick debugging/testing

### --image=busybox:latest
- Uses lightweight BusyBox image
- Includes basic tools like sh, ping, wget, nslookup

### --rm
- Deletes the Pod automatically after exit

### -it
- -i → interactive (keeps STDIN open)
- -t → allocates terminal
- Provides interactive shell access

### --restart=Never
- Ensures a Pod is created (not Deployment)
- Runs only once

### -- sh
- Starts shell inside container

---

## Internal Flow

kubectl → API Server → Pod created → Scheduler → Node → Kubelet → Container runs → Terminal attached

---

## Real Use Cases

1. Test service connectivity
   wget http://my-service

2. DNS debugging
   nslookup kubernetes.default

3. Network testing
   ping <pod-ip>

4. General cluster debugging

---

## Interview One-Liner

Creates a temporary interactive debugging Pod using BusyBox, attaches a shell, and deletes it automatically after use.

---

## Notes

- Mainly used for debugging
- Not for production workloads
- BusyBox has limited tools

---

## Pro Tip

kubectl run debug --image=ubuntu -it --rm -- bash
