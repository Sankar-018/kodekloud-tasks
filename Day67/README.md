# 🧱 Guestbook Application Deployment — Nautilus DevOps Task

This document details the setup of the **Guestbook application** on a Kubernetes cluster. The application uses a Redis master-slave setup as the backend and a PHP frontend for user interaction.

---

## 🧩 Task Overview

The infrastructure consists of three tiers:

| Tier | Component | Description |
|------|------------|-------------|
| **Backend** | Redis Master | Central database for storing guestbook entries |
| **Backend** | Redis Slave | Read replicas for performance and reliability |
| **Frontend** | PHP Application | User interface for managing guest entries |

---

## ⚙️ Kubernetes Resources Overview

| Resource | Name | Type | Replicas | Image | Port | NodePort |
|-----------|------|------|-----------|--------|-------|-----------|
| Deployment | redis-master | Deployment | 1 | redis | 6379 | — |
| Service | redis-master | ClusterIP | — | — | 6379 | — |
| Deployment | redis-slave | Deployment | 2 | gcr.io/google_samples/gb-redisslave:v3 | 6379 | — |
| Service | redis-slave | ClusterIP | — | — | 6379 | — |
| Deployment | frontend | Deployment | 3 | gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff | 80 | — |
| Service | frontend | NodePort | — | — | 80 | 30009 |

---

## 📄 Complete YAML Configuration — `guestbook-deployment.yaml`

```yaml
# ============================== #
# BACKEND TIER — REDIS MASTER    #
# ============================== #
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-master
  labels:
    app: guestbook
    tier: backend
    role: master
spec:
  replicas: 1
  selector:
    matchLabels:
      app: guestbook
      role: master
  template:
    metadata:
      labels:
        app: guestbook
        role: master
    spec:
      containers:
        - name: master-redis-datacenter
          image: redis
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
---
apiVersion: v1
kind: Service
metadata:
  name: redis-master
  labels:
    app: guestbook
    tier: backend
    role: master
spec:
  ports:
    - port: 6379
      targetPort: 6379
  selector:
    app: guestbook
    role: master
---
# ============================== #
# BACKEND TIER — REDIS SLAVE     #
# ============================== #
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis-slave
  labels:
    app: guestbook
    tier: backend
    role: slave
spec:
  replicas: 2
  selector:
    matchLabels:
      app: guestbook
      role: slave
  template:
    metadata:
      labels:
        app: guestbook
        role: slave
    spec:
      containers:
        - name: slave-redis-datacenter
          image: gcr.io/google_samples/gb-redisslave:v3
          env:
            - name: GET_HOSTS_FROM
              value: "dns"
          ports:
            - containerPort: 6379
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
---
apiVersion: v1
kind: Service
metadata:
  name: redis-slave
  labels:
    app: guestbook
    tier: backend
    role: slave
spec:
  ports:
    - port: 6379
      targetPort: 6379
  selector:
    app: guestbook
    role: slave
---
# ============================== #
# FRONTEND TIER — PHP FRONTEND   #
# ============================== #
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  replicas: 3
  selector:
    matchLabels:
      app: guestbook
      tier: frontend
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
        - name: php-redis-datacenter
          image: gcr.io/google-samples/gb-frontend@sha256:a908df8486ff66f2c4daa0d3d8a2fa09846a1fc8efd65649c0109695c7c5cbff
          env:
            - name: GET_HOSTS_FROM
              value: "dns"
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: "100m"
              memory: "100Mi"
---
apiVersion: v1
kind: Service
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  type: NodePort
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30009
  selector:
    app: guestbook
    tier: frontend
```

---

## 🚀 Deployment Steps

```bash
# Step 1: Apply the YAML
kubectl apply -f guestbook-deployment.yaml

# Step 2: Check all deployments, pods, and services
kubectl get deployments
kubectl get pods -o wide
kubectl get svc
```

output:

```
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
redis-master    1/1     1            1           1m
redis-slave     2/2     2            2           1m
frontend        3/3     3            3           1m

NAME            TYPE        CLUSTER-IP      PORT(S)          AGE
redis-master    ClusterIP   10.96.44.150    6379/TCP         1m
redis-slave     ClusterIP   10.96.72.233    6379/TCP         1m
frontend        NodePort    10.96.10.100    80:30009/TCP     1m
```

---

## 🔍 Verification

### 1️⃣ Check Redis Slave Environment
```bash
kubectl exec -it $(kubectl get pod -l role=slave -o name | head -n1) -- env | grep GET_HOSTS_FROM
```
Output:
```
GET_HOSTS_FROM=dns
```

### 2️⃣ Access Guestbook Application

```bash
kubectl get nodes -o wide
```

```

✅ You can access the **Guestbook web interface** by clicking App button on top right corner.

---

## ✅ Final Status

| Component | Status |
|------------|---------|
| Redis Master | ✅ Running |
| Redis Slave | ✅ 2 Pods Running |
| Frontend | ✅ 3 Pods Running |
| Services | ✅ All Created (ClusterIP & NodePort) |
| Guestbook UI | ✅ Accessible on NodePort 30009 |

---

**Task Completed Successfully — Guestbook application deployed and accessible on Kubernetes cluster.**
