# 🐳 Kubernetes PV, PVC, Pod & NodePort Service — Nautilus Web App

Task : The Nautilus DevOps team is working on a Kubernetes template to deploy a web application on the cluster. There are some requirements to create/use persistent volumes to store the application code, and the template needs to be designed accordingly. Please find more details below: Create a PersistentVolume named as pv-nautilus. Configure the spec as storage class should be manual, set capacity to 4Gi, set access mode to ReadWriteOnce, volume type should be hostPath and set path to /mnt/data (this directory is already created, you might not be able to access it directly, so you need not to worry about it). Create a PersistentVolumeClaim named as pvc-nautilus. Configure the spec as storage class should be manual, request 3Gi of the storage, set access mode to ReadWriteOnce. Create a pod named as pod-nautilus, mount the persistent volume you created with claim name pvc-nautilus at document root of the web server, the container within the pod should be named as container-nautilus using image nginx with latest tag only (remember to mention the tag i.e nginx:latest). Create a node port type service named web-nautilus using node port 30008 to expose the web server running within the pod. Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.

This setup deploys an **Nginx web application** on Kubernetes using:
- A **PersistentVolume (PV)** and **PersistentVolumeClaim (PVC)**.
- A **Pod** running `nginx:latest` that mounts the PVC.
- A **NodePort Service** to expose the web app on port **30008**.

---

## 🧱 Step 1 — Create PersistentVolume

```bash
vi pv-nautilus.yaml
```

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-nautilus
spec:
  storageClassName: manual
  capacity:
    storage: 4Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
```

```bash
kubectl apply -f pv-nautilus.yaml
kubectl get pv
```

---

## 🧩 Step 2 — Create PersistentVolumeClaim

```bash
vi pvc-nautilus.yaml
```

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-nautilus
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
```

```bash
kubectl apply -f pvc-nautilus.yaml
kubectl get pvc
```

---

## 🚀 Step 3 — Create Pod (Mount PVC + Fix 403 Issue Automatically)

```bash
vi pod-nautilus.yaml
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod-nautilus
  labels:
    app: nautilus-app
spec:
  initContainers:
  - name: init-web-content
    image: busybox:latest
    command: ['sh', '-c', 'echo "<h1>Welcome to Nautilus App!</h1>" > /usr/share/nginx/html/index.html']
    volumeMounts:
    - name: web-content
      mountPath: /usr/share/nginx/html

  containers:
  - name: container-nautilus
    image: nginx:latest
    volumeMounts:
    - name: web-content
      mountPath: /usr/share/nginx/html

  volumes:
  - name: web-content
    persistentVolumeClaim:
      claimName: pvc-nautilus
```

```bash
kubectl apply -f pod-nautilus.yaml
kubectl get pods -o wide
```

---

## 🌐 Step 4 — Create NodePort Service

```bash
vi web-nautilus.yaml
```

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-nautilus
spec:
  type: NodePort
  selector:
    app: nautilus-app
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30008
```

```bash
kubectl apply -f web-nautilus.yaml
kubectl get svc
```

---

## 🧪 Step 5 — Verify Everything

### Check PV, PVC, Pod, and Service
```bash
kubectl get pv,pvc,pods,svc -o wide
```

### Get Node IP
```bash
kubectl get nodes -o wide
```

Output:
```
NAME                      STATUS   ROLES           AGE   VERSION   INTERNAL-IP   ...
kodekloud-control-plane   Ready    control-plane   32m   v1.27.16  172.17.0.2    ...
```

### Access Web App
```bash
curl http://172.17.0.2:30008
```

✅ **Output:**
```html
<h1>Welcome to Nautilus App!</h1>
```

---


### 🏁 Result
- PersistentVolume and PVC properly bound ✅  
- Pod using PVC mounted at `/usr/share/nginx/html` ✅  
- Nginx served content via NodePort **30008** ✅  
- No 403 Forbidden errors 🚀  
