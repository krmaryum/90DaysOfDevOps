# Task 4: Expose WordPress (Day 53)

## Task Overview

In this task, the WordPress application is exposed outside the Kubernetes cluster using a NodePort Service so it can be accessed through a browser.

## Task Objectives

- Create a NodePort Service for WordPress
- Expose WordPress on port 30080
- Access WordPress in the browser
- Complete the setup wizard
- Verify the setup page is reachable

---

## Create the NodePort Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wordpress
  namespace: capstone
spec:
  type: NodePort
  selector:
    app: wordpress
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

Apply:

```bash
kubectl apply -f wordpress-service.yaml
```

Output:

```text
service/wordpress created
```

---

## Verify Service

```bash
kubectl get svc -n capstone
```

Output:

```text
NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
mysql       ClusterIP   None            <none>        3306/TCP       22h
wordpress   NodePort    10.96.227.200   <none>        80:30080/TCP   10s
```

---

## Access WordPress (Kind)

```bash
kubectl port-forward svc/wordpress 8080:80 -n capstone
```

Then open:

```text
http://localhost:8080
```

---

## Verification

- NodePort Service created successfully
- WordPress accessible via browser
- Setup wizard completed
- WordPress dashboard accessible

**Answer:** Yes — WordPress setup page is accessible and working.

---

## Conclusion

Task 4 was completed successfully. WordPress was exposed using a NodePort Service and accessed through port-forwarding, confirming external access works correctly.

