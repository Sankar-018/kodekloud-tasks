# 🚀 Nginx Deployment and Service on Kubernetes

Task : Some of the Nautilus team developers are developing a static website and they want to deploy it on Kubernetes cluster. They want it to be highly available and scalable. Therefore, based on the requirements, the DevOps team has decided to create a deployment for it with multiple replicas. Below you can find more details about it: Create a deployment using nginx image with latest tag only and remember to mention the tag i.e nginx:latest. Name it as nginx-deployment. The container should be named as nginx-container, also make sure replica counts are 3. Create a NodePort type service named nginx-service. The nodePort should be 30011. Note: The kubectl utility on jump_host has been configured to work with the kubernetes cluster.


This project demonstrates how to deploy a **highly available Nginx web server** on a Kubernetes cluster using a **Deployment** and expose it externally through a **NodePort Service**.

---

## 🎯 Task Objective

* Create a **Deployment** named `nginx-deployment`.
* Use the **nginx:latest** image.
* The container name must be `nginx-container`.
* Set **replica count = 3** for scalability.
* Create a **Service** named `nginx-service` of type **NodePort**.
* NodePort must be **30011**.

---

## 🧾 Deployment Manifest

Create the deployment file `nginx-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
        - name: nginx-container
          image: nginx:latest
          ports:
            - containerPort: 80
```

Apply the configuration:

```bash
kubectl apply -f nginx-deployment.yaml
```

Verify the deployment:

```bash
kubectl get deployments
kubectl get pods -l app=nginx
```

output:

```
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-xxxxx-yyyyy        1/1     Running   0          1m
nginx-deployment-xxxxx-zzzzz        1/1     Running   0          1m
nginx-deployment-xxxxx-wwwww        1/1     Running   0          1m
```

---

## 🌐 Service Manifest

Create the service file `nginx-service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-service
spec:
  type: NodePort
  selector:
    app: nginx
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30011
```

Apply the configuration:

```bash
kubectl apply -f nginx-service.yaml
```

Verify the service:

```bash
kubectl get svc nginx-service
```

output:

```
NAME             TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nginx-service    NodePort   10.96.12.34     <none>        80:30011/TCP   10s
```

```bash
curl http://<node-ip>:30011
```

You should see the default **Nginx Welcome Page** HTML.

---

## ✅ Summary

| Resource           | Name               | Description                     |
| ------------------ | ------------------ | ------------------------------- |
| **Deployment**     | `nginx-deployment` | Runs 3 replicas of Nginx        |
| **Container name** | `nginx-container`  | Nginx container inside each Pod |
| **Service**        | `nginx-service`    | Exposes Pods via NodePort       |
| **NodePort**       | `30011`            | External access port            |
| **Image used**     | `nginx:latest`     | Latest stable Nginx image       |

---
