# Kubernetes HPA Command — Explanation

## Command Used

```bash
kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
```

---

## What This Command Does

This command creates a **Horizontal Pod Autoscaler (HPA)** for the `php-apache` Deployment.

👉 It automatically scales the number of pods based on CPU usage.

---

## Breakdown of the Command

### kubectl autoscale

- Creates an autoscaler (HPA) in Kubernetes

---

### deployment php-apache

- Targets the Deployment named `php-apache`
- This is the application that will scale

---

### --cpu-percent=50

- Target CPU utilization = 50%
- Kubernetes tries to keep CPU usage around 50% of requested CPU

Example:
- CPU request = 200m
- 100m usage = 50%
- 200m usage = 100%

---

### --min=1

- Minimum number of pods = 1
- Autoscaler will never go below this

---

### --max=10

- Maximum number of pods = 10
- Autoscaler will not exceed this limit

---

## How Autoscaling Works

- If CPU usage > 50% → scale UP
- If CPU usage < 50% → scale DOWN

---

## Example Behavior

- Low traffic → 1 pod
- Medium traffic → 2–5 pods
- High traffic → up to 10 pods
- Traffic drops → scales back to 1

---

## Behind the Scenes

```
Metrics Server → provides CPU data
HPA → evaluates usage
HPA → adjusts replicas
Deployment → creates/removes pods
```

---

## Requirements

For HPA to work:

- Metrics Server must be installed
- CPU requests must be defined in Deployment

---

## How to Check HPA

```bash
kubectl get hpa
```

Example output:

```
NAME         TARGETS   MINPODS   MAXPODS   REPLICAS
php-apache   40%/50%   1         10        2
```

---

## Key Concept

HPA uses:

```
CPU usage % = actual usage / requested CPU
```

---

## Useful Command

```bash
kubectl get hpa -w
```

- Watch autoscaling in real time

---

## Summary

- Creates autoscaler for `php-apache`
- Maintains CPU around 50%
- Scales between 1 and 10 pods
- Automatically adjusts based on load
