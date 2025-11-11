# 🧩 Iron Gallery Kubernetes Deployment — Nautilus DevOps Task

This repository contains Kubernetes manifests to deploy the **Iron Gallery App** and its **MariaDB Database** on a Kubernetes cluster under a dedicated namespace.

---

## 🧱 Task Overview

The Nautilus DevOps team customized the **Iron Gallery** application and planned to deploy it on their Kubernetes cluster.  
The deployment includes:
- A **frontend (iron-gallery)** running `kodekloud/irongallery:2.0`
- A **backend database (iron-db)** running `kodekloud/irondb:2.0`
- Two corresponding **services** to expose both components

---

## ⚙️ Requirements Summary

| Resource Type | Name | Key Configurations |
|----------------|------|--------------------|
| **Namespace** | `iron-namespace-nautilus` | All resources deployed inside this namespace |
| **Frontend Deployment** | `iron-gallery-deployment-nautilus` | 1 replica, label `run=iron-gallery`, image `kodekloud/irongallery:2.0` |
| **Frontend Container** | `iron-gallery-container-nautilus` | CPU: 50m, Memory: 100Mi |
| **Frontend Volumes** | `config`, `images` | Both `emptyDir`, mounted to `/usr/share/nginx/html/data` and `/usr/share/nginx/html/uploads` |
| **Backend Deployment** | `iron-db-deployment-nautilus` | 1 replica, label `db=mariadb`, image `kodekloud/irondb:2.0` |
| **Database Container** | `iron-db-container-nautilus` | Environment variables for DB setup, mounted `/var/lib/mysql` |
| **DB Service** | `iron-db-service-nautilus` | Type: ClusterIP, Port: 3306 |
| **Gallery Service** | `iron-gallery-service-nautilus` | Type: NodePort, Port: 80 → NodePort: 32678 |

---

## 📄 YAML Configuration

The complete Kubernetes configuration is included below as a **single declarative manifest**.

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: iron-namespace-nautilus
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-gallery-deployment-nautilus
  namespace: iron-namespace-nautilus
  labels:
    run: iron-gallery
spec:
  replicas: 1
  selector:
    matchLabels:
      run: iron-gallery
  template:
    metadata:
      labels:
        run: iron-gallery
    spec:
      containers:
        - name: iron-gallery-container-nautilus
          image: kodekloud/irongallery:2.0
          resources:
            limits:
              memory: "100Mi"
              cpu: "50m"
          volumeMounts:
            - name: config
              mountPath: /usr/share/nginx/html/data
            - name: images
              mountPath: /usr/share/nginx/html/uploads
      volumes:
        - name: config
          emptyDir: {}
        - name: images
          emptyDir: {}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iron-db-deployment-nautilus
  namespace: iron-namespace-nautilus
  labels:
    db: mariadb
spec:
  replicas: 1
  selector:
    matchLabels:
      db: mariadb
  template:
    metadata:
      labels:
        db: mariadb
    spec:
      containers:
        - name: iron-db-container-nautilus
          image: kodekloud/irondb:2.0
          env:
            - name: MYSQL_DATABASE
              value: database_web
            - name: MYSQL_ROOT_PASSWORD
              value: "Root@1234!"
            - name: MYSQL_USER
              value: "ironuser"
            - name: MYSQL_PASSWORD
              value: "Iron@5678"
          volumeMounts:
            - name: db
              mountPath: /var/lib/mysql
      volumes:
        - name: db
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: iron-db-service-nautilus
  namespace: iron-namespace-nautilus
spec:
  selector:
    db: mariadb
  type: ClusterIP
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
---
apiVersion: v1
kind: Service
metadata:
  name: iron-gallery-service-nautilus
  namespace: iron-namespace-nautilus
spec:
  selector:
    run: iron-gallery
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 32678
```

---

## 🚀 Deployment Steps

Run these commands sequentially:

```bash
# Step 1: Create namespace
kubectl create namespace iron-namespace-nautilus

# Step 2: Apply the deployment manifest
kubectl apply -f iron-gallery-deployment.yaml

# Step 3: Verify deployments and services
kubectl get all -n iron-namespace-nautilus
```

---

## 🔍 Verification

Check deployments:

```bash
kubectl get deployments -n iron-namespace-nautilus --show-labels
```

Check services:

```bash
kubectl get svc -n iron-namespace-nautilus
```
output:

```
NAME                            TYPE        CLUSTER-IP      PORT(S)        AGE
iron-db-service-nautilus        ClusterIP   10.xx.xx.xx     3306/TCP       ...
iron-gallery-service-nautilus   NodePort    10.xx.xx.xx     80:32678/TCP   ...
```

Check pods:

```bash
kubectl get pods -n iron-namespace-nautilus -o wide
```

---

## 🌐 Access the Iron Gallery App

Find your **Node IP**:

```bash
kubectl get nodes -o wide
```
---

## ✅ Deployment Status

| Resource | Status |
|-----------|---------|
| Namespace | ✅ Created |
| Deployments | ✅ Running (1/1 each) |
| Pods | ✅ Ready |
| Services | ✅ Exposed correctly |
| NodePort | ✅ Accessible (32678) |

---
