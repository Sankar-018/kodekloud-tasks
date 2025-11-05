# ☸️ Kubernetes Deployment - HTTPD Web Server

 Task : The Nautilus DevOps team is delving into Kubernetes for app management. One team member needs to create a deployment following these details: Create a deployment named httpd to deploy the application httpd using the image httpd:latest (ensure to specify the tag) Note: The kubectl utility on jump_host is set up to interact with the Kubernetes cluster.
 
## 🧩 Project Overview
This task demonstrates how to create a **Kubernetes Deployment** for an HTTPD web server using the `httpd:latest` image.  
The deployment ensures the containerized web server runs reliably under Kubernetes management.

---

## 📁 Deployment Specifications

| Property | Value |
|-----------|--------|
| **Deployment Name** | `httpd` |
| **Container Name** | `httpd` |
| **Image** | `httpd:latest` |
| **Replicas** | 1 |
| **Label** | `app=httpd` |

---

## 🧾 YAML Manifest

Create a file named **`httpd-deployment.yaml`** with the following content:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: httpd
spec:
  replicas: 1
  selector:
    matchLabels:
      app: httpd
  template:
    metadata:
      labels:
        app: httpd
    spec:
      containers:
        - name: httpd
          image: httpd:latest
```

---

## ⚙️ Deployment Steps

1. **Create the deployment manifest**
   ```bash
   vi httpd-deployment.yaml
   ```
   

2. **Apply the deployment**
   ```bash
   kubectl apply -f httpd-deployment.yaml
   ```

    output:
   ```
   deployment.apps/httpd created
   ```

3. **Verify the deployment and pods**
   ```bash
   kubectl get deployments
   kubectl get pods -l app=httpd
   ```

    output:
   ```
   NAME    READY   UP-TO-DATE   AVAILABLE   AGE
   httpd   1/1     1            1           10s
   ```
