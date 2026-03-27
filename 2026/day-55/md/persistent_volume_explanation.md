# Kubernetes PersistentVolume Explanation

``` yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-static-demo
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: ""
  hostPath:
    path: /tmp/k8s-pv-data
```

## Line-by-line Explanation

### apiVersion: v1

This tells Kubernetes which API version is being used for this resource.

-   `v1` is the core API group in Kubernetes.
-   `PersistentVolume` is part of this core API.

### kind: PersistentVolume

This tells Kubernetes what type of object you are creating.

-   A `PersistentVolume` (PV) is a piece of storage in the cluster.
-   It is usually created by an admin or manually defined.
-   It exists independently of pods.

### metadata:

This section contains identifying information about the object.

### name: pv-static-demo

This is the name of the PersistentVolume.

-   Other resources can refer to it by this name.

------------------------------------------------------------------------

### spec:

This section defines the desired configuration of the PersistentVolume.

### capacity:

Defines how much storage the volume provides.

### storage: 1Gi

This says the volume has **1 gibibyte** of storage.

------------------------------------------------------------------------

### accessModes:

Defines how the volume can be mounted.

### ReadWriteOnce

-   The volume can be mounted as read-write by **one node at a time**.

------------------------------------------------------------------------

### persistentVolumeReclaimPolicy: Retain

Defines what happens after the claim is deleted.

-   `Retain` keeps the data.
-   Manual cleanup is required.

------------------------------------------------------------------------

### storageClassName: ""

-   No storage class is assigned.
-   Used for static provisioning.

------------------------------------------------------------------------

### hostPath:

Specifies the storage backend.

-   Uses a directory on the node.

### path: /tmp/k8s-pv-data

-   Actual directory used on the node.

------------------------------------------------------------------------

## Summary

This creates a **1Gi static volume**:

-   Local node storage
-   Single-node writable
-   Data retained after use

## Use Case

Best for: - Local development - Testing environments

Not ideal for production.
