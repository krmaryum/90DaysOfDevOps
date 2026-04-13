# Task 5: Test Self-Healing and Persistence

## Task Overview

In this task, the WordPress + MySQL application was tested for Kubernetes self-healing and data persistence.

## Task Objectives

- Delete a WordPress Pod and verify it is recreated
- Delete the MySQL Pod and verify it is recreated
- Confirm WordPress still works after recovery
- Verify that blog data is not lost

---

## Test WordPress Self-Healing

```bash
kubectl get pods -n capstone
```

```text
NAME                         READY   STATUS    RESTARTS   AGE
mysql-0                      1/1     Running   0          23h
wordpress-74b7956d66-5mmzb   1/1     Running   0          21h
wordpress-74b7956d66-6772s   1/1     Running   0          21h
```

Delete Pod:

```bash
kubectl delete pod wordpress-74b7956d66-5mmzb -n capstone
```

Output:

```text
pod "wordpress-74b7956d66-5mmzb" deleted from capstone namespace
```

Watch:

```bash
kubectl get pods -n capstone -w
```

```text
wordpress-74b7956d66-4zbt4   0/1     Running
wordpress-74b7956d66-4zbt4   1/1     Running
```

---

## Test MySQL Self-Healing

```bash
kubectl delete pod mysql-0 -n capstone
```

Output:

```text
pod "mysql-0" deleted from capstone namespace
```

Watch:

```bash
kubectl get pods -n capstone -w
```

```text
mysql-0   1/1   Running   0   7s
```

---

## Verify Persistence

- Refreshed WordPress in browser
- Blog post still present

---

## Verification

- WordPress Pod recreated automatically
- MySQL Pod recreated automatically
- Application remained accessible
- Data persisted successfully

**Answer:** Yes — the blog post is still there after deleting both Pods.

---

## Conclusion

Task 5 was completed successfully. Kubernetes self-healing and persistent storage worked as expected.

