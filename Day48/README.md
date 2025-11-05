# ☸️ Kubernetes Pod Deployment - Nginx App

## 🧩 Project Overview
This task involves creating and deploying a simple Nginx Pod in a Kubernetes cluster using `kubectl`.  
The pod will serve as part of the **xFusionCorp Industries** DevOps team's Kubernetes learning and testing environment.

---

## 📁 Pod Specifications

| Property | Value |
|-----------|--------|
| **Pod Name** | `pod-nginx` |
| **Container Name** | `nginx-container` |
| **Image** | `nginx:latest` |
| **Label** | `app=nginx_app` |

---

## 🧾 YAML Manifest

Create a file named **`pod-nginx.yaml`** with the following content:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-nginx
  labels:
    app: nginx_app
spec:
  containers:
    - name: nginx-container
      image: nginx:latest
```

---

## ⚙️ Deployment Steps

1. **Create the YAML file**
   ```bash
   vi pod-nginx.yaml
   ```
   Paste the YAML content above, then save and exit.

2. **Apply the manifest to create the pod**
   ```bash
   kubectl apply -f pod-nginx.yaml
   ```

3. **Verify the pod creation**
   ```bash
   kubectl get pods
   ```
   Example output:
   ```
   NAME         READY   STATUS    RESTARTS   AGE
   pod-nginx    1/1     Running   0          10s
   ```
