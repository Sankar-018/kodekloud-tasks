# ☸️ Kubernetes Rolling Update - Nginx Deployment

Task : An application currently running on the Kubernetes cluster employs the nginx web server. The Nautilus application development team has introduced some recent changes that need deployment. They've crafted an image nginx:1.18 with the latest updates. 

Execute a rolling update for this application, integrating the nginx:1.18 image. The deployment is named nginx-deployment. 

Ensure all pods are operational post-update. 

Note: The kubectl utility on jump_host is set up to operate with the Kubernetes cluster

## 🧩 Task Overview
Perform a **rolling update** on the existing Kubernetes deployment `nginx-deployment` to use the new image `nginx:1.18`.

---

## ⚙️ Steps to Perform

1. **Check existing deployment**
   ```bash
   kubectl get deployments
   kubectl describe deployment nginx-deployment | grep Image:
   ```

2. **Update deployment image**
   ```bash
   kubectl set image deployment/nginx-deployment nginx=nginx:1.18
   ```

3. **Monitor rollout status**
   ```bash
   kubectl rollout status deployment/nginx-deployment
   ```

4. **Verify updated image and pods**
   ```bash
   kubectl describe deployment nginx-deployment | grep Image:
   kubectl get pods
   ```

   Output:
   ```
   Image:  nginx:1.18
   STATUS: Running
   ```
