# REST API Request (Kubernetes Context)

## What is a REST API Request?

A REST API request is a way for one system (like kubectl) to communicate with another system (like the Kubernetes API Server) using HTTP.

---

## Simple Analogy

- Client (kubectl) → You
- API Server → Waiter
- Kubernetes → Kitchen

You send a request like: "Create 3 nginx pods"

---

## Kubernetes Example

Command:
kubectl apply -f app-deployment.yaml

REST API request sent:
POST /apis/apps/v1/namespaces/default/deployments

---

## Structure of a REST API Request

### 1. Method (Action)

- GET → Read data
- POST → Create resource
- PUT → Replace resource
- PATCH → Update resource
- DELETE → Remove resource

kubectl apply usually uses POST or PATCH.

---

### 2. URL (Endpoint)

/apis/apps/v1/namespaces/default/deployments

- /apis → API group
- /apps/v1 → version
- /namespaces/default → namespace
- /deployments → resource

---

### 3. Headers

Authorization: Bearer <token>
Content-Type: application/json

---

### 4. Body (Payload)

{
  "kind": "Deployment",
  "metadata": { "name": "web-app" },
  "spec": { "replicas": 3 }
}

(YAML is converted to JSON)

---

## Flow in Kubernetes

kubectl → API Server → etcd

---

## Interview Definition

A REST API request is an HTTP request used to perform operations (GET, POST, PUT, DELETE) on resources, where each resource is identified by a URL and communication is stateless.

---

## Why Kubernetes Uses REST

- Standard HTTP protocol
- Stateless communication
- Resource-based architecture (Pods, Deployments, Services)

---

## One-Line Interview Answer

Kubernetes uses REST API requests where kubectl sends HTTP requests like POST or PATCH to the API Server to manage cluster resources.
