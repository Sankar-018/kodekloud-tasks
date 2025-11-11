# 🐍 Python Flask App Deployment — DevOps Fix Task

This repository documents the investigation and fix of a **Python Flask application** deployed on a Kubernetes cluster by the Nautilus DevOps team. The application initially failed to start due to a misconfigured image and service port mismatch.

---

## 🧱 Task Overview

A DevOps engineer deployed a Python Flask app but faced issues with the application not coming up.  
You were asked to troubleshoot and fix it so that the application becomes accessible on the specified **NodePort (32345)**.

---

## 🧩 Problem Summary

| Issue | Root Cause | Fix |
|--------|-------------|-----|
| **Pods not running** | Incorrect image name `poroko/flask-app-demo` | Corrected to `poroko/flask-demo-app` |
| **App not accessible** | Service used wrong port (8080) instead of Flask’s default (5000) | Updated Service to `port: 5000`, `targetPort: 5000`, `nodePort: 32345` |

---

## ⚙️ Corrected Kubernetes Configuration

### ✅ Deployment (Fixed)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: python-deployment-devops
spec:
  replicas: 1
  selector:
    matchLabels:
      app: python_app
  template:
    metadata:
      labels:
        app: python_app
    spec:
      containers:
        - name: python-container-devops
          image: poroko/flask-demo-app
          ports:
            - containerPort: 5000
```

### ✅ Service (Fixed)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: python-service-devops
spec:
  type: NodePort
  selector:
    app: python_app
  ports:
    - protocol: TCP
      port: 5000
      targetPort: 5000
      nodePort: 32345
```

---

## 🚀 Deployment Steps

```bash
# Step 1: Verify deployment and service exist
kubectl get deployments
kubectl get svc

# Step 2: Edit the deployment image (if broken)
kubectl edit deployment python-deployment-devops
# Change image to poroko/flask-demo-app

# Step 3: Wait for rollout to finish
kubectl rollout status deployment python-deployment-devops

# Step 4: Edit the service and fix port mappings
kubectl edit svc python-service-devops
# Change port and targetPort from 8080 → 5000

# Step 5: Verify configuration
kubectl get svc
```

 output:
```
NAME                    TYPE        CLUSTER-IP      PORT(S)          AGE
python-service-devops   NodePort    10.xx.xx.xx     5000:32345/TCP   ...
```

---

## 🔍 Verification

Check pods are running:
```bash
kubectl get pods
```
```

App output:
```
Hello World from Flask App!
```

---

## 🧠 Explanation of Port Configuration

| Layer | Port | Description |
|--------|------|-------------|
| **Flask App (inside container)** | 5000 | Flask’s default port |
| **Service Target Port** | 5000 | Forwards traffic to Flask container |
| **Service Port** | 5000 | Entry point for in-cluster traffic |
| **NodePort** | 32345 | Exposes the app externally to users |

---

## ✅ Final Status

| Resource | Status |
|-----------|---------|
| Deployment | ✅ Running (1/1 Ready) |
| Pod | ✅ Healthy |
| Service | ✅ NodePort (5000:32345/TCP) |
| Accessibility | ✅ Reachable via NodeIP:32345 |

---
